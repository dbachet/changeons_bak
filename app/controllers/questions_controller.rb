# -*- encoding : utf-8 -*-
class QuestionsController < AuthorizedController
  include ActionView::Helpers::TextHelper
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  add_breadcrumb "Questions", :questions_path, :title => "Revenir à la liste des questions", :except => %w(index show)
  before_filter :authenticate_user!, :except => [:show, :index]
  
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
      if current_user.voted_for?(@question)
        current_user.clear_votes(@question)
      else
        current_user.vote_exclusively_for(@question)
      end
      @votes_result = @question.plusminus
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'layouts/vote_up'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  # GET /questions
  # GET /questions.xml
  def index
    
    
    if params[:category_id]                                                     # TO CHANGE
      @category = Category.find_by_cached_slug(params[:category_id])
      @questions = @category.questions.published.recent.page(params[:page]).per(5)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Questions", questions_from_category_path(@category), :title => "Revenir à la liste des questions"
    else
      add_breadcrumb "Questions", :questions_path, :title => "Revenir à la liste des questions"
      @questions = Question.published.recent.page(params[:page]).per(5)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    # @question = Question.find(params[:id])
    @user = @question.user
    @answers = @question.answers.published.recent
    @answer = Answer.new
    
    @categories = @question.categories
    @votes_result = @question.plusminus
    also_to_read_items(@categories)
    
    accessed_from_this_category = accessed_from_category
    if !accessed_from_this_category.nil?                                         # TO CHANGE
      @category = Category.find_by_cached_slug(accessed_from_this_category)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Questions", questions_from_category_path(@category), :title => "Revenir à la liste des questions"
      add_breadcrumb truncate(@question.title, :length => 30), :question_path
    else
      add_breadcrumb "Questions", :questions_path, :title => "Revenir à la liste des questions"
      add_breadcrumb truncate(@question.title, :length => 30), :question_path
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    # @question = Question.new
    @presentation_picture = PresentationPicture.new
    add_breadcrumb "Nouvelle question", :new_question_path
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    # @question = Question.find(params[:id])
    @presentation_picture = @question.presentation_picture || PresentationPicture.new
    add_breadcrumb truncate(@question.title, :length => 20), :question_path
    add_breadcrumb "Éditer la question", :edit_question_path
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = current_user.questions.create(params[:question])
    @presentation_picture = PresentationPicture.find_by_id(params[:question][:presentation_picture_id])
    
    respond_to do |format|
      if @question.save
        if @presentation_picture.present?
          manage_presentation_picture(@question, params[:question][:presentation_picture_id])
        end
        @question.moderation_setting = ModerationSetting.create(:published => true, :moderated => false, :refuse_cause => "-")
        format.html { redirect_to(@question, :notice => "La question a été créee avec succès !") }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        if params[:question][:presentation_picture_id].present?
          @presentation_picture = PresentationPicture.find_by_id(params[:question][:presentation_picture_id])
        else
          @presentation_picture = PresentationPicture.new
        end
        flash.now[:alert] = t(:form_record_fail, :model => "a question", :scope => [:errors])
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @presentation_picture = PresentationPicture.find_by_id(params[:question][:presentation_picture_id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        manage_presentation_picture(@question, params[:question][:presentation_picture_id])
        @question.pending_for_moderation
        format.html { redirect_to(@question, :notice => "La question a été mise à jour avec succès !") }
        format.xml  { head :ok }
      else
        if params[:question][:presentation_picture_id].present?
          @presentation_picture = PresentationPicture.find_by_id(params[:question][:presentation_picture_id])
        else
          @presentation_picture = PresentationPicture.new
        end
        flash.now[:alert] = t(:form_record_fail, :model => "a question", :scope => [:errors])
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
end
