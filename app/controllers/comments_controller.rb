class CommentsController < ApplicationController
  # MUST STAY BEFORE :authenticate_user!
  # before_filter :sign_in_if_guest, :only => :create
  
  before_filter :authenticate_user!, :only => [:create, :create_reply, :destroy, :update]
  # after_filter :destroy_guest, :only => :create
  
  # show the fields to write comment as a guest
  def show_guest_fields
    @post = Post.find(params[:post_id])
    @new_comment = Comment.new
    
    
    respond_to do |format|
      # format.html { redirect_to error_pages_javascript_disabled_path, :alert => "The guest posting is not authorized when javascript is disabled." }
      format.html { redirect_to comment_as_guest_path(@post) }
      format.js
    end
  end
  
  # show the fields to write reply as a guest
  def show_guest_fields_for_reply
    @post = Post.find(params[:post_id])
    # @reply = Comment.new
    
    respond_to do |format|
      # format.html { redirect_to error_pages_javascript_disabled_path, :alert => "The guest posting is not authorized when javascript is disabled." }
      format.html { redirect_to reply_as_guest_path(@post) }
      format.js
    end
  end
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  
  # TO REMOVE IF THOUGHT AS OR REDIRECT TO POST/SHOW
  def show
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  def reply
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @reply = Comment.new
    @new_comment = Comment.new
    
    if is_reply_allowed?(@new_comment)
      @comments = @post.comment_threads
      @tags = @post.tag_list
      @votes_result = @post.plusminus
      
      render :action => "posts/show"
    else
      redirect_to(@post, :alert => "You are not allowed man to reply a reply! Don't even try boy, it could cost you the life!")
    end
  end
  
  def create_reply
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    
    @reply = Comment.build_from( @post, current_user, params[:comment][:body], params[:comment][:title] )
    
    if @reply.save
      @reply.move_to_child_of(@comment)
      redirect_to(@post, :notice => 'Comment was successfully created.')
    else
      @new_comment = Comment.new
      @comments = @post.comment_threads
      @tags = @post.tag_list
      @votes_result = @post.plusminus
      render :action => "posts/show"
    end
  end
  
  def comment_as_guest
    @post = Post.find(params[:post_id])
    @new_comment = Comment.new
    @new_comment.user_id = -1
    
    @comments = @post.comment_threads
    @tags = @post.tag_list
    @votes_result = @post.plusminus
    render :action => "posts/show"
  end
  
  def create_comment_as_guest
    @post = Post.find(params[:post_id])
    
    @new_comment = Comment.build_from_as_guest( @post, params[:comment][:body], params[:comment][:title], params[:comment][:guest_email], params[:comment][:guest_website] )
    
    if @new_comment.save
      redirect_to(@post, :notice => 'Comment was successfully created as a guest comment.')
    else
      @comments = @post.comment_threads
      @tags = @post.tag_list
      @votes_result = @post.plusminus
      render :action => "posts/show"
    end
  end
  
  def reply_as_guest
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    
    @new_comment = Comment.new

    
    @reply = Comment.new
    @reply.user_id = -1
    
    if is_reply_allowed?(@new_comment)
      @comments = @post.comment_threads
      @tags = @post.tag_list
      @votes_result = @post.plusminus
      
      render :action => "posts/show"
    else
      redirect_to(@post, :alert => "You are not allowed man to reply a reply! Don't even try boy, it could cost you the life!")
    end
  end
  
  def create_reply_as_guest
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @new_comment = Comment.new
    
    @reply = Comment.build_from_as_guest( @post, params[:comment][:body], params[:comment][:title], params[:comment][:guest_email], params[:comment][:guest_website] )
    
    if @reply.save
      @reply.move_to_child_of(@comment)
      redirect_to(@post, :notice => 'Comment was successfully created as a guest comment.')
    else
      @new_comment = Comment.new
      @comments = @post.comment_threads
      @tags = @post.tag_list
      @votes_result = @post.plusminus
      render :action => "posts/show"
    end
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @post = Post.find(params[:post_id])
    @new_comment = Comment.build_from( @post, current_user, params[:comment][:body], params[:comment][:title] )
    

    if @new_comment.save
      redirect_to(@post, :notice => 'Comment was successfully created.')
    else
      @comments = @post.comment_threads
      @tags = @post.tag_list
      @votes_result = @post.plusminus
      render :action => "posts/show"
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@post, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(post_comments_path) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def sign_in_if_guest
    if !current_user
      sign_in(guest_user)
      puts "GUEST SIGNED IN"
    end
  end
  
  def destroy_guest
    if current_user.role == "guest"
      sign_out(guest_user)
      guest_user.destroy
      session[:guest_user_id] = nil
    end
  end
  
  # Forbid the user to reply to a reply
  def is_reply_allowed?(comment)
    if comment.parent_id.nil?
      true
      # redirect_to(post, :alert => "You are not allowed man to reply a reply! Don't even try boy, it could cost you the life!")
    end
  end
end
