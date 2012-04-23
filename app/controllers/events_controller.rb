# -*- encoding : utf-8 -*-
class EventsController < AuthorizedController
  include ActionView::Helpers::TextHelper
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  add_breadcrumb "Évènements", :events_path, :title => "Revenir à la liste des évènements", :except => %w(index show)
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def add_source
    @page = params[:controller]
    
    respond_to do |format|
      format.js { render 'layouts/add_source'}
    end
  end
  
  def remove_source
    @source = params[:source]
    @page = params[:controller]
    
    respond_to do |format|
      format.js { render 'layouts/remove_source'}
    end
  end
  
  def vote_up
    begin
      if current_user.voted_for?(@event)
        current_user.clear_votes(@event)
      else
        current_user.vote_exclusively_for(@event)
      end
      @votes_result = @event.plusminus
      
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'layouts/vote_up'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  # GET /events
  # GET /events.xml
  def index
    if params[:category_id]                                                     # TO CHANGE
      @category = Category.find_by_cached_slug(params[:category_id])
      @events = @category.events.published.recent.page(params[:page]).per(5)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Évènements", events_from_category_path(@category), :title => "Revenir à la liste des évènements"
    else
      add_breadcrumb "Évènements", :events_path, :title => "Revenir à la liste des évènements"
      @events = Event.published.recent.page(params[:page]).per(5)
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    @user = @event.user
    @categories = @event.categories
    
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @comment = Comment.new
    @from = 0
    @limitation = @default_comment_offset
    @comments = Comment.fetch_comments(@event, @from, 10)
    
    also_to_read_items(@categories)
    
    @displayed_comments = @comments.length
    @remaining_comments = @event.root_comments.count - @displayed_comments
    
    declare_variables_reply_form_after_login  # if guest fills reply form and logs in, then we have to declare these variables to 
                                              # be able to display reply form
    
    @votes_result = @event.plusminus
    
    
    accessed_from_this_category = accessed_from_category
    if !accessed_from_this_category.nil?                                         # TO CHANGE
      @category = Category.find_by_cached_slug(accessed_from_this_category)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Évènements", events_from_category_path(@category), :title => "Revenir à la liste des évènements"
      add_breadcrumb truncate(@event.title, :length => 30), :event_path
    else
      add_breadcrumb "Évènements", :events_path, :title => "Revenir à la liste des évènements"
      add_breadcrumb truncate(@event.title, :length => 30), :event_path
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    # @event = Event.new
    @presentation_picture = PresentationPicture.new
    add_breadcrumb "Nouvel évènement", :new_event_path
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    # @event = Event.find(params[:id])
    @presentation_picture = @event.presentation_picture || PresentationPicture.new
    add_breadcrumb truncate(@event.title, :length => 20), :event_path
    add_breadcrumb "Éditer l'évènement", :edit_event_path
  end

  # POST /events
  # POST /events.xml
  def create
    @event = current_user.events.new(params[:event])
    @presentation_picture = PresentationPicture.find_by_id(params[:event][:presentation_picture_id])
    # @event.categories.build params[:event][:category_ids]
    # @event.event_start_date = Timeliness.parse(@event.event_start_date, :format => 'dd/mm/yyyy')

    respond_to do |format|
      if @event.save
        if @presentation_picture.present?
          manage_presentation_picture(@event, params[:event][:presentation_picture_id])
        end
        @event.moderation_setting = ModerationSetting.create(:published => true, :moderated => false, :refuse_cause => "-")
        format.html { redirect_to(@event, :notice => "L'évènement a été crée avec succès !") }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        if params[:event][:presentation_picture_id].present?
          @presentation_picture = PresentationPicture.find_by_id(params[:event][:presentation_picture_id])
        else
          @presentation_picture = PresentationPicture.new
        end
        flash.now[:alert] = t(:form_record_fail, :model => "'évènement", :scope => [:errors])
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    # @event.categories.build params[:event][:category_ids]
    @presentation_picture = PresentationPicture.find_by_id(params[:event][:presentation_picture_id])
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        if @presentation_picture.present?
          manage_presentation_picture(@event, params[:event][:presentation_picture_id])
        end
        @event.pending_for_moderation
        format.html { redirect_to(@event, :notice => "L'évènement a été mis à jour avec succès !") }
        format.xml  { head :ok }
      else
        if params[:event][:presentation_picture_id].present?
          @presentation_picture = PresentationPicture.find_by_id(params[:event][:presentation_picture_id])
        else
          @presentation_picture = PresentationPicture.new
        end
        flash.now[:alert] = t(:form_record_fail, :model => "'évènement", :scope => [:errors])
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
