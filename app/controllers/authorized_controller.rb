class AuthorizedController < ApplicationController
  # before_filter :authenticate_user!
  check_authorization
  load_and_authorize_resource
  
  rescue_from CanCan::AccessDenied do |exception|
   flash[:error] = exception.message
   
   
   # redirect_to root_url
   respond_to do |format|
     format.html { redirect_to root_url }
     format.js { redirect_to new_user_session_path }
   end
  end
  
  # protected
  # 
  #   class << self
  # 
  #     attr_reader :parents
  # 
  #     def parent_resources(*parents)
  #       @parents = parents
  #     end
  # 
  #   end
  # 
  #   def parent_id(parent)
  #     request.path_parameters["#{ parent }_id"]
  #   end
  # 
  #   def parent_type
  #     self.class.parents.detect { |parent| parent_id(parent) }
  #   end
  # 
  #   def parent_class
  #     parent_type && parent_type.to_s.classify.constantize
  #   end
  # 
  #   def parent_object
  #     parent_class && parent_class.find_by_id(parent_id(parent_type))
  #   end
  
  # rescue_from CanCan::AccessDenied do |exception|
  #   Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
  #   # ...
  # end

  
end