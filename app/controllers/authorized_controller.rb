class AuthorizedController < ApplicationController
  # before_filter :authenticate_user!
  check_authorization
  load_and_authorize_resource
  
  rescue_from CanCan::AccessDenied do |exception|
   flash[:error] = exception.message
   
   
   # redirect_to root_url
   respond_to do |format|
     format.html { redirect_to root_url, :status => :unauthorized }
     format.js { redirect_to new_user_session_path }
   end
  end
  
  # rescue_from CanCan::AccessDenied do |exception|
  #   Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
  #   # ...
  # end

  
end