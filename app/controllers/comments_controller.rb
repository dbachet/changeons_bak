class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
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
    check_reply_ability(@comment, @post)
  end
  
  def create_reply
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    check_reply_ability(@comment, @post)
    
    @reply = Comment.build_from( @post, current_user, params[:comment][:body], params[:comment][:title] )
    
    if @reply.save
      @reply.move_to_child_of(@comment)
      redirect_to(@post, :notice => 'Comment was successfully created.')
    else
      render :action => "reply"
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
    puts "** TEST COMMENT **"
    @comment = Comment.build_from( @post, current_user, params[:comment][:body], params[:comment][:title] )
    
    # @comment.save
    # @comment.move_to_child_of(Comment.all.first)
    puts "** END TEST COMMENT **"
    
    # @comment = Comment.new(params[:comment])
    # @post = Post.find(params[:post_id])
    # @comment.user_id = current_user.id
    # @comment.post_id = @post.id
    # @post = Post.find(params[:id])
    # @post.inspect

    if @comment.save
      redirect_to(@post, :notice => 'Comment was successfully created.')
    else
      # render :action => "new"
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
  
  # Forbid the user to reply to a reply
  def check_reply_ability(comment, post)
    if !comment.parent_id.blank?
      redirect_to(post, :alert => "You are not allowed man to reply a reply! Don't even try boy, it could cost you the life!")
    end
  end
end
