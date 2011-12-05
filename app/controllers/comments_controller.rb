class CommentsController < AuthorizedController
  # MUST STAY BEFORE :authenticate_user!
  # before_filter :sign_in_if_guest, :only => :create
  # load_and_authorize_resource
  respond_to :js
  
  
  before_filter :authenticate_user!, :only => [:edit, :create, :create_reply, :destroy, :update]
  # after_filter :destroy_guest, :only => :create
  
  def show_more_comments
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @post = Post.find(params[:post_id])
    @comments = Comment.fetch_comments(@post, params[:offset], @default_comment_offset)
    @comments_count = @post.root_comments.count - (@comments.length + params[:offset].to_i)
    
    
    respond_with
      # format.js
      # format.html { render :nothing => true, :status => 404}
    
  end
  
  # # GET /comments
  # # GET /comments.xml
  # def index
  #   @comments = Comment.all
  #   @post = Post.find(params[:post_id])
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @comments }
  #   end
  # end

  # # GET /comments/1
  # # GET /comments/1.xml
  # 
  # # TO REMOVE IF THOUGHT AS OR REDIRECT TO POST/SHOW
  # def show
  #   @comment = Comment.find(params[:id])
  #   @post = Post.find(params[:post_id])
  #   
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @comment }
  #   end
  # end

  # # GET /comments/new
  # # GET /comments/new.xml
  # def new
  #   @comment = Comment.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @comment }
  #   end
  # end
  
  # show the reply fields
  def show_reply
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    
    @new_reply = Comment.new
    
    respond_with
    # respond_to do |format|
      # format.html { redirect_to reply_post_comment_path(@post, @comment, :anchor => "reply_comment_#{@comment.id}") }
      # format.js
    # end
  end
  
  # show the fields to write comment as a guest
  def show_guest_fields
    @post = Post.find(params[:post_id])
    @new_comment = Comment.new
    @new_comment.user_id = -1
    
    respond_with
    # respond_to do |format|
      # format.html { redirect_to error_pages_javascript_disabled_path, :alert => "The guest posting is not authorized when javascript is disabled." }
      # format.html { redirect_to comment_as_guest_path(@post) }
      # format.js
    # end
  end
  
  # show the fields to write reply as a guest
  def show_guest_fields_for_reply
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @new_reply = Comment.new
    @new_reply.user_id = -1
    
    respond_with
    # respond_to do |format|
      # format.html { redirect_to error_pages_javascript_disabled_path, :alert => "The guest posting is not authorized when javascript is disabled." }
      # format.html { redirect_to reply_as_guest_path(@post) }
      # format.js
    # end
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
    
    
    respond_with do |format|
      if @new_comment.save
        @comment = Comment.set_comment_hash(@new_comment)
        @new_comment= Comment.new
        flash[:notice] = 'Comment was successfully created.'
        # redirect_to(@post, :notice => 'Comment was successfully created.')
      else
        flash[:alert] = 'Comment was not successfully created.'
              # @comments = @post.comment_threads
              # @tags = @post.tag_list
              # @votes_result = @post.plusminus
              # render :action => "posts/show"
      end
    end
  end
  
  def create_comment_as_guest
    @post = Post.find(params[:post_id])
    
    @new_comment = Comment.build_from_as_guest( @post, params[:comment][:body], params[:comment][:title], params[:comment][:guest_email], params[:comment][:guest_website] )
    
    respond_with do |format|
      if @new_comment.save
        @comment = Comment.set_comment_hash(@new_comment)
        @new_comment= Comment.new
        flash[:notice] = 'Comment was successfully created.'
        format.js { render :create }
      else
        flash[:alert] = 'Comment was not successfully created.'
      end
    end
    
    # if @new_comment.save
    #   redirect_to(@post, :notice => 'Comment was successfully created as a guest comment.')
    # else
    #   @comments = @post.comment_threads
    #   @tags = @post.tag_list
    #   @votes_result = @post.plusminus
    #   render :action => "posts/show"
    # end
  end
  
  def create_reply
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    
    @new_reply = Comment.build_from( @post, current_user, params[:reply][:body], params[:reply][:title] )
    
    respond_with do |format|
      if @new_reply.save
        @new_reply.move_to_child_of(@comment)
        @reply = Comment.set_comment_hash(@new_reply, @comment)
        flash[:notice] = 'Comment was successfully created.'
      else
        flash[:alert] = 'Comment was not successfully created.'
      end
    end
    
    # if @reply.save
    #   @reply.move_to_child_of(@comment)
    #   redirect_to(@post, :notice => 'Comment was successfully created.')
    # else
    #   @new_comment = Comment.new
    #   @comments = @post.comment_threads
    #   @tags = @post.tag_list
    #   @votes_result = @post.plusminus
    #   render :action => "posts/show"
    # end
  end
  
  def create_reply_as_guest
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @new_comment = Comment.new
    
    @new_reply = Comment.build_from_as_guest( @post, params[:reply][:body], params[:reply][:title], params[:reply][:guest_email], params[:reply][:guest_website] )
    
    respond_with do |format|
      if @new_reply.save
        @new_reply.move_to_child_of(@comment)
        @reply = Comment.set_comment_hash(@new_reply, @comment)
        flash[:notice] = 'Comment was successfully created.'
        format.js { render :create_reply }
      else
        flash[:alert] = 'Comment was not successfully created.'
      end
    end
    
    # if @reply.save
    #   @reply.move_to_child_of(@comment)
    #   redirect_to(@post, :notice => 'Comment was successfully created as a guest comment.')
    # else
    #   @new_comment = Comment.new
    #   @comments = @post.comment_threads
    #   @tags = @post.tag_list
    #   @votes_result = @post.plusminus
    #   render :action => "posts/show"
    # end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    # respond_with do |format|
    #   if @reply.save
    #     @reply.move_to_child_of(@comment)
    #     flash[:notice] = 'Comment was successfully created.'
    #   else
    #     flash[:alert] = 'Comment was not successfully created.'
    #   end
    # end
    
    # respond_to do |format|
    #       if @comment.update_attributes(params[:comment])
    #         format.html { redirect_to(@post, :notice => 'Comment was successfully updated.') }
    #         format.xml  { head :ok }
    #       else
    #         format.html { render :action => "edit" }
    #         format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
    #       end
    #     end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    
    if @comment.has_children?
      @comment.children.each do |child|
        child.destroy
      end
    end
    @comment.destroy

    respond_with
  end
  
  private
  
  # def sign_in_if_guest
  #   if !current_user
  #     sign_in(guest_user)
  #     puts "GUEST SIGNED IN"
  #   end
  # end
  
  # def destroy_guest
  #   if current_user.role == "guest"
  #     sign_out(guest_user)
  #     guest_user.destroy
  #     session[:guest_user_id] = nil
  #   end
  # end
  
  # Forbid the user to reply to a reply
  def is_reply_allowed?(comment)
    if comment.parent_id.nil?
      true
      # redirect_to(post, :alert => "You are not allowed man to reply a reply! Don't even try boy, it could cost you the life!")
    end
  end
end
