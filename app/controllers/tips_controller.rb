# -*- encoding : utf-8 -*-
class TipsController < AuthorizedController
  include ActionView::Helpers::TextHelper
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  add_breadcrumb "Astuces", :tips_path, :title => "Revenir à la liste des astuces", :except => %w(index show)
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
      if current_user.voted_for?(@tip)
        current_user.clear_votes(@tip)
      else
        current_user.vote_exclusively_for(@tip)
      end
      @votes_result = @tip.plusminus
      
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'layouts/vote_up'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  # GET /tips
  # GET /tips.xml
  def index
    
    
    if params[:category_id]                                                     # TO CHANGE
      @category = Category.find_by_cached_slug(params[:category_id])
      @tips = @category.tips.published.recent.page(params[:page]).per(5)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Astuces", tips_from_category_path(@category), :title => "Revenir à la liste des astuces"
    else
      add_breadcrumb "Astuces", :tips_path, :title => "Revenir à la liste des astuces"
      @tips = Tip.published.recent.page(params[:page]).per(5)
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tips }
    end
  end

  # GET /tips/1
  # GET /tips/1.xml
  def show
    # @tip = Tip.find(params[:id])
    @user = @tip.user
    @categories = @tip.categories
    
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @comment = Comment.new
    @from = 0
    @limitation = @default_comment_offset
    @comments = Comment.fetch_comments(@tip, @from, 10)
    
    # puts @tip.categories.first.id
    
    declare_variables_reply_form_after_login  # if guest fills reply form and logs in, then we have to declare these variables to 
                                              # be able to display reply form
    
    also_to_read_items(@categories)
    

    
    @displayed_comments = @comments.length
    @remaining_comments = @tip.root_comments.count - @displayed_comments
    
    
    @votes_result = @tip.plusminus
    accessed_from_this_category = accessed_from_category
    if !accessed_from_this_category.nil?                                         # TO CHANGE
      @category = Category.find_by_cached_slug(accessed_from_this_category)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Astuces", posts_from_category_path(@category), :title => "Revenir à la liste des astuces"
      add_breadcrumb truncate(@tip.title, :length => 30), :tip_path
    else
      add_breadcrumb "Astuces", :tips_path, :title => "Revenir à la liste des astuces"
      add_breadcrumb truncate(@tip.title, :length => 30), :tip_path
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tip }
    end
  end

  # GET /tips/new
  # GET /tips/new.xml
  def new
    # @tip = Tip.new
    @presentation_picture = PresentationPicture.new
    # @upload_picture = UploadPicture.new
    
    add_breadcrumb "Nouvelle astuce", :new_tip_path
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tip }
    end
  end

  # GET /tips/1/edit
  def edit
    # @tip = Tip.find(params[:id])
    @presentation_picture = @tip.presentation_picture || PresentationPicture.new 
    add_breadcrumb truncate(@tip.title, :length => 20), :tip_path
    add_breadcrumb "Éditer l'astuce", :edit_tip_path
  end

  # POST /tips
  # POST /tips.xml
  def create
    # @tip = current_user.tips.new(params[:tip])
    
    respond_to do |format|
      if @tip.save
        
        
        manage_presentation_picture(@tip, params[:tip][:presentation_picture_id])
        
        @tip.moderation_setting = ModerationSetting.create(:published => true, :moderated => false, :refuse_cause => "-")
        
        
        format.html { redirect_to(@tip, :notice => 'Tip was successfully created.') }
        format.xml  { render :xml => @tip, :status => :created, :location => @tip }
      else
        @presentation_picture = @tip.presentation_picture || PresentationPicture.new
        format.html { render :action => "new" }
        format.xml  { render :xml => @tip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tips/1
  # PUT /tips/1.xml
  def update
    @tip = Tip.find(params[:id])
    
    respond_to do |format|
      if @tip.update_attributes(params[:tip])
        
        manage_presentation_picture(@tip, params[:tip][:presentation_picture_id])
        @tip.pending_for_moderation
        
        
        
        format.html { redirect_to(@tip, :notice => 'Tip was successfully updated.') }
        format.xml  { head :ok }
      else
        @presentation_picture = @tip.presentation_picture || PresentationPicture.new
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.xml
  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy

    respond_to do |format|
      format.html { redirect_to(tips_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
end
