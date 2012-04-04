# -*- encoding : utf-8 -*-
class CommentsController < AuthorizedController
  # MUST STAY BEFORE :authenticate_user!
  # before_filter :sign_in_if_guest, :only => :create
  # load_and_authorize_resource
  # skip_load_and_authorize_resource :except => [:destroy]
  respond_to :js, :except => :edit
  
  # parent_resources :post, :tip, :event, :product_test
  
  
  before_filter :authenticate_user!, :only => [:edit, :create, :create_reply, :destroy, :update]
  # after_filter :destroy_guest, :only => :create
  
  def show_more_comments
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @post = Post.find(params[:post_id])
    @comments = Comment.fetch_comments(@post, params[:displayed_comments], @default_comment_offset)
    # @comments_count = @post.root_comments.count - (@comments.length + params[:offset].to_i)
    
    @displayed_comments = @comments.length + params[:displayed_comments].to_i
    @remaining_comments = @post.root_comments.count - @displayed_comments
    
    # authorize! :show_more_comments, @comments
    # authorize! :show_more_comments, @post
    # puts "post => #{@post.inspect} / comment => #{@comment.inspect} / comments => #{@comments}"
    
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
    # @post = Post.find(params[:post_id])
    commentable = find_commentable_object
    @root_comment = Comment.find(params[:root_comment_id])
    
    @reply = Comment.new
    
    
    # authorize! :show_reply, @comment
    # authorize! :show_reply, @post
    # puts "post => #{@post.inspect} / comment => #{@comment.inspect}"
    
    respond_with
    # respond_to do |format|
      # format.html { redirect_to reply_post_comment_path(@post, @comment, :anchor => "reply_comment_#{@comment.id}") }
      # format.js
    # end
  end
  
  # show the fields to write comment as a guest
  def show_guest_fields
    commentable = find_commentable_object
    @comment = Comment.new
    @comment.user_id = -1
    
    
    # authorize! :show_reply, @comment
    # authorize! :show_reply, @post
    # puts "post => #{@post.inspect} / comment => #{@comment.inspect}"
    
    respond_with
    # respond_to do |format|
      # format.html { redirect_to error_pages_javascript_disabled_path, :alert => "The guest posting is not authorized when javascript is disabled." }
      # format.html { redirect_to comment_as_guest_path(@post) }
      # format.js
    # end
  end
  
  # show the fields to write reply as a guest
  def show_guest_fields_for_reply
    commentable = find_commentable_object
    @root_comment = Comment.find(params[:root_comment_id])
    @reply = Comment.new
    @reply.user_id = -1
    
    @comment = Comment.new
    
    # authorize! :show_reply, @comment
    # authorize! :show_reply, @post
    # puts "post => #{@post.inspect} / comment => #{@comment.inspect}"
    
    respond_with
    # respond_to do |format|
      # format.html { redirect_to error_pages_javascript_disabled_path, :alert => "The guest posting is not authorized when javascript is disabled." }
      # format.html { redirect_to reply_as_guest_path(@post) }
      # format.js
    # end
  end
  
  # GET /comments/1/edit
  def edit
    commentable = find_commentable_object
    
    @comment = Comment.find(params[:id])
    
    # authorize! :edit, :comment
    respond_with do |format|
      format.html { render :edit, :layout => false}
    end
  end

  # POST /comments
  # POST /comments.xml
  def create
    commentable = find_commentable_object
    @comment = Comment.build_from(commentable, current_user.id, params[:comment][:body], params[:comment][:title], params[:comment][:send_notification_to_root_comment] )
        
    respond_with do |format|
      if @comment.save
        @comment_created = Comment.set_comment_hash(@comment)
        @comment = Comment.new
        flash[:notice] = 'Comment was successfully created.'
      else
        flash[:alert] = 'Comment was not successfully created.'
              # @comments = @post.comment_threads
              # @tags = @post.tag_list
              # @votes_result = @post.plusminus
              # render :action => "posts/show"
      end
    end
  end
  
  def create_as_guest
    commentable = find_commentable_object
    
    @comment = Comment.build_from_as_guest(commentable, params[:comment][:body], params[:comment][:title], params[:comment][:guest_email], params[:comment][:guest_website], params[:comment][:send_notification_to_root_comment] )
    
    respond_with do |format|
      if verify_recaptcha(:model => @comment, :message => "Vous n'avez pas saisi les bons mots !") && @comment.save
        @comment_created = Comment.set_comment_hash(@comment)
        @comment= Comment.new
        flash[:notice] = 'Comment was successfully created.'
        format.js { render :create }
      else
        flash[:alert] = 'Comment was not successfully created.'
        puts @comment.errors.inspect
        format.js { render :error_comment }
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
    commentable = find_commentable_object
    @root_comment = Comment.find(params[:root_comment_id])
    
    @reply = Comment.build_from(commentable, current_user.id, params[:reply][:body], params[:reply][:title])
    
    
    respond_with do |format|
      if @reply.save
        @reply.move_to_child_of(@root_comment)
        
        if @root_comment.send_notification_to_root_comment?
          Comment.send_notification_to_root_comment(@root_comment, @reply) 
        end
        
        # @reply = Comment.set_comment_hash(@reply, @root_comment)
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
    # @post = Post.find(params[:post_id])
    commentable = find_commentable_object
    @root_comment = Comment.find(params[:root_comment_id])
    
    @reply = Comment.build_from_as_guest(commentable, params[:reply][:body], params[:reply][:title], params[:reply][:guest_email], params[:reply][:guest_website] )
    
    respond_with do |format|
      if verify_recaptcha(:model => @reply, :message => "Vous n'avez pas saisi les bons mots !") && @reply.save
        @reply.move_to_child_of(@root_comment)
        
        
        if @root_comment.send_notification_to_root_comment?
          Comment.send_notification_to_root_comment(@root_comment, @reply) 
        end
        
        # @reply = Comment.set_comment_hash(@reply, @root_comment)
        flash[:notice] = 'Comment was successfully created.'
        format.js { render :create_reply }
      else
        flash[:alert] = 'Comment was not successfully created.'
        format.js { render :error_comment }
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
    commentable = find_commentable_object
    @comment = Comment.find(params[:id])
    
    respond_with do |format|
      if @comment.update_attributes(params[:comment])
        @comment_updated = @comment
        @comment= Comment.new
        
        flash[:notice] = 'Comment was successfully updated.'
      else
        flash[:alert] = 'Comment was not successfully updated.'
      end
    end
    
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
    
    
    if @comment.has_children?
      @comment.children.each do |child|
        child.destroy
      end
    end
    @comment.destroy

    respond_with
  end
  
  private

    def find_commentable_object
      case
        when params[:commentable_type] == "post" then @post = Post.find(params[:commentable_id])
        when params[:commentable_type] == "tip" then @tip = Tip.find(params[:commentable_id])
        when params[:commentable_type] == "event" then @event = Event.find(params[:commentable_id])
        when params[:commentable_type] == "product_test" then @product_test = ProductTest.find(params[:commentable_id])
      end    
    end  

    
    # def parent_comment_show_reply(parent)
    #   case
    #     when params[:article_id] then article_url(parent)
    #     when params[:news_id] then news_url(parent)
    #     when params[:post_id] then 
    #     when params[:tip_id] then Tip.find(params[:tip_id])
    #     when params[:event_id] then Event.find(params[:event_id])
    #     when params[:product_test_id] then ProductTest.find(params[:product_test_id])
    #   end    
    # end
  
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
