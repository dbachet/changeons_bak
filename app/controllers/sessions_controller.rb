# -*- encoding : utf-8 -*-
class SessionsController < Devise::SessionsController
    ###########################################
    # To add in config/initializers/devise.rb #
    ###########################################
    
    # config.http_authenticatable_on_xhr = false
    # config.navigational_formats = [:html, :json]
    #*********************************************#
    
    layout false, :only => :new
    # respond_to :html, :except => [:new]
    # respond_to :js, :only => [:new]
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "sessions#failure")
    !resource.nil? ? @result = true : @result = false
    
    
    # SHOULDN'T BE HERE
    # @action = params[:user][:action]
    # if !@action.blank?
    #       if @action == "show_post"
    #         @post = Post.find(params[:user][:post_id])
    #         @root_comment = Comment.find(params[:user][:root_comment_id]) unless params[:user][:root_comment_id].empty?
    #         @reply = Comment.new
    #         @comment = Comment.new
    #         
    #         @displayed_comments = params[:user][:displayed_comments].to_i
    #         @comments = Comment.fetch_comments(@post, 0, @displayed_comments)
    #         @remaining_comments = @post.root_comments.count - @displayed_comments
    #       elsif @action == "index_post"
    #         @displayed_posts = params[:user][:displayed_posts].to_i
    #         @posts = Post.recent.limit(@displayed_posts)
    #         @remaining_posts = Post.count - @displayed_posts
    #       end
    #     end
    
    

    # SHOULDN'T BE HERE
    
    return sign_in_and_redirect(resource_name, resource)
  end
  
  # def new
  #   # SHOULDN'T BE HERE
  #   @post_id = params[:post_id]
  #   @comment_id = params[:comment_id]
  #   # SHOULDN'T BE HERE
  #   
  #   resource = build_resource
  #   clean_up_passwords(resource)
  #   respond_with_navigational(resource, stub_options(resource)){ render :fancy_login, :layout => false }
  # end
  
  # def new
  #   
  # end
  
  # #######
  # GET /resource/sign_in
  def new
    # SHOULDN'T BE HERE
    # @action = params[:action]
    # @post_id = params[:post_id]
    # @root_comment_id = params[:root_comment_id]
    # SHOULDN'T BE HERE
    
    
    resource = build_resource
    clean_up_passwords(resource)
    # respond_with(resource) do |format|
    #   format.js {render :new}
    #   # format.any(*navigational_formats, &stub_options(resource))
    # end
    respond_with_navigational(resource, stub_options(resource)){ render_with_scope :new }
  end

  # POST /resource/sign_in
  # def create
  #   resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
  #   set_flash_message(:notice, :signed_in) if is_navigational_format?
  #   sign_in(resource_name, resource)
  #   respond_with resource, :location => after_sign_in_path_for(resource)
  # end
  # #######
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    
    # puts "Result -> #{@result}"
    # return render :create => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
    # return render :sign_in_and_redirect => {:redirect => :back}
        respond_to do |format|
          # format.html { redirect_to(:back) }
          format.js { render :sign_in_and_redirect }
        end
  end

  def failure
    # return render :json => {:success => false, :errors => ["Login failed."]}
  end
  
end

# class SessionsController < Devise::SessionsController
#   # layout false
#   
#   def create
#       resource = warden.authenticate!(:scope => resource_name, :recall => :failure)
#       # puts "Resource -> #{resource}"
#       
#       # SHOULDN'T BE HERE
#       @comment = Comment.new
#       # SHOULDN'T BE HERE
#       
#       if !resource.nil?
#         return sign_in_and_redirect(resource_name, resource)
#       else
#         return failure
#       end
#   end
# 
#   def fancy_comment_login
#     resource = build_resource
#     clean_up_passwords(resource)
#     respond_with_navigational(resource, stub_options(resource)){ render :fancy_comment_login, :layout => false }
#   end
#   
#   def sign_in_and_redirect(resource_or_scope, resource=nil)
#     scope = Devise::Mapping.find_scope!(resource_or_scope)
#     resource ||= resource_or_scope
#     set_flash_message(:notice, :signed_in) if is_navigational_format?
#     sign_in(scope, resource) unless warden.user(scope) == resource
#     
#     # return render :js => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
#     # return render :create 
#     respond_to do |format|
#       format.js { render :sign_in_and_redirect }
#     end
#   end
# 
#   def failure
#     @test_var = "The combination of email/password is incorrect"
#     puts test_var
#     flash[:alert] = "The combination of email/password is incorrect"
#     # respond_to do |format|
#     #       format.js { render :failure }
#     #     end
#     # return render :js => {:success => false, :errors => ["Login failed."]}
#     return render :js
#   end
# 
# end
