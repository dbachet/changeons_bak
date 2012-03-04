class PostsController < AuthorizedController
  include ActionView::Helpers::TextHelper
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  add_breadcrumb "Articles", :posts_path, :title => "Revenir à la liste des articles"
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
    if params[:category]
      @category = Category.find_by_cached_slug(params[:category])
      puts @category.name
      @posts = @category.posts.page(params[:page]).per(5)
    else
      @posts = Post.recent.page(params[:page]).per(5)
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
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @comment = Comment.new
    # @post = Post.find(params[:id])
    @from = 0
    @limitation = @default_comment_offset
    @comments = Comment.fetch_comments(@post, @from, @limitation)
  
    
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
    
    add_breadcrumb truncate(@post.title, :length => 30), :post_path
    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    # @post = Post.new
    add_breadcrumb "Nouvel article", :new_post_path
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    add_breadcrumb truncate(@post.title, :length => 20), :post_path
    add_breadcrumb "Éditer l'article", :edit_post_path
    # @post = Post.find(params[:id])
    # authorize! :edit, @post
    # puts "post => #{@post.inspect}" # / comment => #{@comment.inspect}"
    
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.create(params[:post])
    @post.tag_list = params[:post][:tag_list]
    @post.category_ids = params[:post][:category_ids]
    puts  "#{@post.errors}"
    
    respond_to do |format|
      if @post.save
        
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    # @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        @post.tag_list = params[:post][:tag_list]
        @post.save
        @post.category_ids = params[:post][:category_ids]
        
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
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
