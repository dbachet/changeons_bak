# -*- encoding : utf-8 -*-
class PostsController < AuthorizedController
  include ActionView::Helpers::TextHelper
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  add_breadcrumb "Articles", :posts_path, :title => "Revenir à la liste des articles", :except => %w(index show)  # TO CHANGE
  # skip_load_and_authorize_resource :only => [:show]
  before_filter :authenticate_user!, :except => [:index, :show, :show_more_posts, :archives]
  # load_and_authorize_resource
  # before_filter :authenticate_user!
  
  
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
  
  def show_more_posts
    @default_post_offset = APP_CONFIG['default_post_offset']
    @posts = Post.recent.offset(params[:displayed_posts]).limit(@default_post_offset)
    # @posts_count = Post.count - (@posts.length + params[:offset].to_i)
    
    @displayed_posts = @posts.length + params[:displayed_posts].to_i
    @remaining_posts = Post.count - @displayed_posts
    
    # puts "post => #{@post.inspect}"
    # # authorize! :show_more_posts, @post
    
    respond_to do |format|
      format.js
      # format.html { render :nothing => true, :status => 404}
    end
  end
  
  def vote_up
    begin
      if current_user.voted_for?(@post)
        current_user.clear_votes(@post)
      else
        current_user.vote_exclusively_for(@post)
      end
      @votes_result = @post.plusminus
      
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'layouts/vote_up'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def vote_down
    begin
      if current_user.voted_against?(@post)
        current_user.clear_votes(@post)
      else
        current_user.vote_exclusively_against(@post)
      end
      @votes_result = @post.plusminus
      
      # authorize! :vote_down, @post
      
      respond_to do |format|
        format.js
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def archives
    add_breadcrumb "Archives des anciens articles", :posts_archives_path
    authorize! :archives, Post
  end
  
  # GET /posts
  # GET /posts.xml
  def index
    if params[:category_id]                                                     # TO CHANGE
      @category = Category.find_by_cached_slug(params[:category_id])
      @posts = @category.posts.published.recent.page(params[:page]).per(5)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Articles", posts_from_category_path(@category), :title => "Revenir à la liste des articles"
    else
      add_breadcrumb "Articles", :posts_path, :title => "Revenir à la liste des articles"
      @posts = Post.published.recent.page(params[:page]).per(5)
    end
    @default_post_offset = APP_CONFIG['default_post_offset']
    # @posts = Post.recent.page(params[:page]).per(5)
    @tags =  ActsAsTaggableOn::Tag.all
    
    @displayed_posts = @posts.length
    @remaining_posts = Post.count - @displayed_posts
    
    # authorize! :index, @post
    # authorize! :index, @posts_count
    # authorize! :index, @posts
    
    # puts "posts => #{@posts.inspect}"
    
    # TO REFACTOR
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @user = @post.user
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @comment = Comment.new
    @from = 0
    @limitation = @default_comment_offset
    @comments = Comment.fetch_comments(@post, @from, 10)
    
    declare_variables_reply_form_after_login  # if guest fills reply form and logs in, then we have to declare these variables to 
                                              # be able to display reply form
    
    @displayed_comments = @comments.length
    @remaining_comments = @post.root_comments.count - @displayed_comments
    # authorize! :index, @post
    # authorize! :edit, :comment
    # puts "post => #{@post.inspect}"
    # puts "@comments_count => #{@comments_count} / @post.root_comments.count => #{@post.root_comments.count} / @comments.length => #{@comments.length}"
    
    @categories = @post.categories
    also_to_read_items(@categories)
    
    # @post_type = @post.post_type.name
    @tags = @post.tag_list
    @votes_result = @post.plusminus
    
    accessed_from_this_category = accessed_from_category
    if !accessed_from_this_category.nil?                                         # TO CHANGE
      @category = Category.find_by_cached_slug(accessed_from_this_category)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Articles", posts_from_category_path(@category), :title => "Revenir à la liste des articles"
      add_breadcrumb truncate(@post.title, :length => 30), :post_path
    else
      add_breadcrumb "Articles", :posts_path, :title => "Revenir à la liste des articles"
      add_breadcrumb truncate(@post.title, :length => 30), :post_path
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    # @post = Post.new
    # @post.categories.build
    @presentation_picture = PresentationPicture.new
    add_breadcrumb "Nouvel article", :new_post_path
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @presentation_picture = @post.presentation_picture || PresentationPicture.new
    add_breadcrumb truncate(@post.title, :length => 20), :post_path, :title => "Revenir à l'article"
    add_breadcrumb "Éditer l'article", :edit_post_path
    
    # @post = Post.find(params[:id])
    # authorize! :edit, @post
    # puts "post => #{@post.inspect}" # / comment => #{@comment.inspect}"
    
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.new(params[:post])
    @post.tag_list = params[:post][:tag_list]
    @presentation_picture = PresentationPicture.find_by_id(params[:post][:presentation_picture_id])
    
    # @post.categories.build params[:post][:category_ids]
    # Category.attach_to(@post, params[:post][:category_ids])
    
    respond_to do |format|
      if @post.save
        # generates slug for the tag
        if @presentation_picture.present?
          manage_presentation_picture(@post, params[:post][:presentation_picture_id])
        end
        @post.moderation_setting = ModerationSetting.create(:published => true, :moderated => false, :refuse_cause => "-")
        @post.tags.each do |tag|
          tag.save
        end
        
        format.html { redirect_to(@post, :notice => "L'article a été crée avec succès !") }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        if params[:post][:presentation_picture_id].present?
          @presentation_picture = PresentationPicture.find_by_id(params[:post][:presentation_picture_id])
        else
          @presentation_picture = PresentationPicture.new
        end
        flash.now[:alert] = t(:form_record_fail, :model => "'article", :scope => [:errors])
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    # @post = Post.find(params[:id])
    @post.tag_list = params[:post][:tag_list]
    @presentation_picture = PresentationPicture.find_by_id(params[:post][:presentation_picture_id])
    # @post.categories.build params[:post][:category_ids]
    
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        # generates slug for the tag
        @post.tags.each do |tag|
          tag.save
        end
        
        if @presentation_picture.present?
          manage_presentation_picture(@post, params[:post][:presentation_picture_id])
        end
        
        @post.pending_for_moderation
        format.html { redirect_to(@post, :notice => "L'article a été mis à jour avec succès !") }
        format.xml  { head :ok }
      else
        if params[:post][:presentation_picture_id].present?
          @presentation_picture = PresentationPicture.find_by_id(params[:post][:presentation_picture_id])
        else
          @presentation_picture = PresentationPicture.new
        end
        flash.now[:alert] = t(:form_record_fail, :model => "'article", :scope => [:errors])
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    # @post = Post.find(params[:id])
    @post.category_ids = []
    @post.tag_list = []
    @post.save
    @post.destroy
    
    

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
end
