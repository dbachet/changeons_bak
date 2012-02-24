class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :newsletter_subscriber, :fetch_best_items, :top_item, :changeons_items
  
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
  
  def also_to_read_items(category)
    @also_to_read_posts = category.posts.limit(3)
    @also_to_read_tips = category.tips.limit(3)
    @also_to_read_events = category.events.limit(3)
    @also_to_read_product_tests = category.product_tests.limit(3)
    
    puts @also_to_read_posts.inspect
    puts @also_to_read_tips
    puts @also_to_read_events
    puts @also_to_read_product_tests
  end
  
  def fetch_best_items
    @best_items = Tip.all
    @best_items2 = Event.all
  end
  
  def top_item
    @top_item = Post.where("has_big_picture = ? AND picture_orientation_horizontal = ?", true, true).limit(1)
    puts "Top item = #{@top_item.inspect}"
  end
  
  def changeons_items
    @changeons_quoi = Question.find(1).answers
    @changeons_pourquoi = Question.find(2).answers
  end
  
  def signed_in_as_admin?
    user = current_user || User.new
    if !user.role?("admin")
      redirect_to root_path
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
  
  
  # def create_guest_user
  #   u = User.new(:email => "guest_#{Time.now.to_i}#{rand(99)}@email_address.com", :role => "guest")
  #   u.skip_confirmation!
  #   u.save(false)
  #   u
  # end
end
