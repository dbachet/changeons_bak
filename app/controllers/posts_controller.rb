class PostsController < AuthorizedController
  # skip_load_and_authorize_resource :only => [:show]
  before_filter :authenticate_user!, :except => [:index, :show, :show_more_posts]
  # load_and_authorize_resource
  # before_filter :authenticate_user!
  
  
  def show_more_posts
    @default_post_offset = APP_CONFIG['default_post_offset']
    @posts = Post.recent.offset(params[:displayed_comments])
    # @posts_count = Post.count - (@posts.length + params[:offset].to_i)
    
    @displayed_posts = @posts.length + params[:displayed_posts].to_i
    @remaining_posts = Post.count - @displayed_posts
    
    # puts "posts => #{@posts.inspect}"
    # puts "post => #{@post.inspect}"
    # # authorize! :show_more_posts, @post
    
    respond_to do |format|
      format.js
      # format.html { render :nothing => true, :status => 404}
    end
  end
  
  def vote_up
    begin
      current_user.vote_exclusively_for(@post)
      @votes_result = @post.plusminus
      
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def vote_down
    begin
      current_user.vote_exclusively_against(@post)
      @votes_result = @post.plusminus
      
      # authorize! :vote_down, @post
      
      respond_to do |format|
        format.js
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  
  # GET /posts
  # GET /posts.xml
  def index
    @default_post_offset = APP_CONFIG['default_post_offset']
    @posts = Post.recent
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

    @tags = @post.tag_list
    @votes_result = @post.plusminus
    
    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    # @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    # @post = Post.find(params[:id])
    # authorize! :edit, @post
    # puts "post => #{@post.inspect}" # / comment => #{@comment.inspect}"
    
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.new(params[:post])
    @post.tag_list = params[:post][:tag_list]
    
    # authorize! :create, @post
    
    respond_to do |format|
      if @post.save
        @post.category_ids = params[:post][:category_ids]
        
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
