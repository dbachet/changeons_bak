class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :newsletter_subscriber
  
  # if user is logged in, return current_user, else return guest_user
  # def current_or_guest_user
  #   if current_user
  #     if session[:guest_user_id]
  #       logging_in
  #       guest_user.destroy
  #       session[:guest_user_id] = nil
  #     end
  #     current_user
  #   else
  #     guest_user
  #   end
  # end

  # find guest_user object associated with the current session,
  # creating one as needed
  # def guest_user
  #   User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  # end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  # def logging_in
  # end

  private
  
  def newsletter_subscriber
    @newsletter_subscriber = NewsletterSubscriber.new
  end
  
  def signed_in_as_admin?
    user = current_user || User.new
    if !user.role?("admin")
      redirect_to root_path
    end
  end

  
  
  # def create_guest_user
  #   u = User.new(:email => "guest_#{Time.now.to_i}#{rand(99)}@email_address.com", :role => "guest")
  #   u.skip_confirmation!
  #   u.save(false)
  #   u
  # end
end
