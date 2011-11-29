class SessionsController < Devise::SessionsController
    ###########################################
    # To add in config/initializers/devise.rb #
    ###########################################
    
    # config.http_authenticatable_on_xhr = false
    # config.navigational_formats = [:html, :json]
    #*********************************************#
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "sessions#failure")
    !resource.nil? ? @result = true : @result = false

    # SHOULDN'T BE HERE
    @post = Post.find(params[:user][:post_id]) unless params[:user][:post_id].empty? || params[:user][:post_id] == "undefined"
    @comment = Comment.find(params[:user][:comment_id]) unless params[:user][:comment_id].empty?|| params[:user][:comment_id] == "undefined"
    @reply = Comment.new unless params[:user][:comment_id].empty?|| params[:user][:comment_id] == "undefined"
    @new_comment = Comment.new unless params[:user][:post_id].empty? || params[:user][:post_id] == "undefined"
    # SHOULDN'T BE HERE
        
    return sign_in_and_redirect(resource_name, resource)
  end
  
  def new
    # SHOULDN'T BE HERE
    @post_id = params[:post_id]
    @comment_id = params[:comment_id]
    # SHOULDN'T BE HERE
    
    resource = build_resource
    clean_up_passwords(resource)
    respond_with_navigational(resource, stub_options(resource)){ render :fancy_login, :layout => false }
  end
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    
    puts "Result -> #{@result}"
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