class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :show_more_posts]
  
  def show_more_posts
    @default_post_offset = APP_CONFIG['default_post_offset']
    @posts = Post.recent.offset(params[:offset])
    @posts_count = Post.count - (@posts.length + params[:offset].to_i)
    
    
    respond_to do |format|
      format.js
      # format.html { render :nothing => true, :status => 404}
    end
  end
  
  def vote_up
    begin
      current_user.vote_exclusively_for(@post = Post.find(params[:id]))
      @votes_result = @post.plusminus
      respond_to do |format|
        format.js
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def vote_down
    begin
      current_user.vote_exclusively_against(@post = Post.find(params[:id]))
      @votes_result = @post.plusminus
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
    @posts_count = Post.count - @posts.length
    
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
    @post = Post.find(params[:id])    
    @new_comment = Comment.new
    
    
    @comments = Comment.fetch_comments(@post, 0)
    @comments_count = @post.root_comments.count - @comments.length
    
    puts "@comments_count => #{@comments_count} / @post.root_comments.count => #{@post.root_comments.count} / @comments.length => #{@comments.length}"

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
    @post = current_user.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.new(params[:post])
    @post.tag_list = params[:post][:tag_list]
    
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
    @post = Post.find(params[:id])

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
    @post = Post.find(params[:id])
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
