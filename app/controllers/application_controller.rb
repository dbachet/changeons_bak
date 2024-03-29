# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :newsletter_subscriber, :fetch_best_items, :top_item, :categories
  # before_filter :changeons_items
  
  rescue_from CanCan::AccessDenied do |exception|
   flash[:error] = exception.message
   
   
   # redirect_to root_url
   respond_to do |format|
     format.html { redirect_to root_url }
     format.js { redirect_to new_user_session_path }
   end
  end
  
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
  
  def get_last_from_redaction
    posts = Post.member_of_redaction.published.recent.limit(20)
    tips = Tip.member_of_redaction.published.recent.limit(20)
    questions = Question.member_of_redaction.published.recent.limit(20)
    events = Event.member_of_redaction.published.recent.limit(20)
    product_tests = ProductTest.member_of_redaction.published.recent.limit(20)
    
    hash = {}
    
    posts.each do |post|
    	hash[post.created_at] = post
    end
    
    tips.each do |tip|
    	hash[tip.created_at] = tip
    end
    
    questions.each do |question|
    	hash[question.created_at] = question
    end
    
    events.each do |event|
    	hash[event.created_at] = event
    end
    
    product_tests.each do |product_test|
    	hash[product_test.created_at] = product_test
    end
    
    hash
  end
  
  def manage_presentation_picture(object, presentation_picture_id)
    presentation_picture = PresentationPicture.find_by_id(presentation_picture_id)
    if !object.presentation_picture    # NO picture stored
      if !presentation_picture.nil?  &&  presentation_picture.presentation_picturable.nil?    # A new picture is provided and exists but is not used in another model
        presentation_picture.attach(object)
      end
    else                                  # A picture is stored
      if presentation_picture_id == ""      # the picture has to be removed
        object.presentation_picture.destroy             # We destroy picture        
      elsif !presentation_picture.nil?               # A new picture is provided and exists
        if object.presentation_picture.id != presentation_picture.id  &&  presentation_picture.presentation_picturable.nil?    # A new picture is provided and exists but is not used in another model
          object.presentation_picture.destroy             # We destroy picture
          presentation_picture.attach(object)
        end
      end
    end
  end
  
  def declare_variables_reply_form_after_login
    @root_comment_id = cookies["replyParentId"]
    if !@root_comment_id.nil?
      case
        when params[:controller] == "posts" then @comment_parent_object = Post.find(params[:id])
        when params[:controller] == "tips" then @comment_parent_object = Tip.find(params[:id])
        when params[:controller] == "events" then @comment_parent_object = Event.find(params[:id])
        when params[:controller] == "product_tests" then @comment_parent_object = ProductTest.find(params[:id])
      end
      
      @root_comment = Comment.find(@root_comment_id)
      @reply = Comment.new
    end
  end
  
  def accessed_from_category
    if !request.referrer.nil?
      previous_url = request.referrer.split("/")
      if previous_url[3] == "categories"
        return previous_url[4].split("?")[0]
      elsif previous_url[4] == "categories"
        return previous_url[5].split("?")[0]
      end
    end
  end
  
  def newsletter_subscriber
    @newsletter_subscriber = NewsletterSubscriber.new
  end
  
  def categories
    @menu_categories = Category.all
  end
  
  def also_to_read_items(categories)
    category = categories[rand(categories.size)]
    
    @also_to_read_posts = category.posts.limit(3)
    @also_to_read_tips = category.tips.limit(3)
    @also_to_read_events = category.events.limit(3)
    @also_to_read_product_tests = category.product_tests.limit(3)
    
    # puts @also_to_read_posts.inspect
    # puts @also_to_read_tips
    # puts @also_to_read_events
    # puts @also_to_read_product_tests
  end
  
  def fetch_best_items
    @best_items = Tip.all
    @best_items2 = Event.all
  end
  
  def top_item
    @top_item = Post.where("has_big_picture = ? AND picture_orientation_horizontal = ?", true, true).limit(1)
    # puts "Top item = #{@top_item.inspect}"
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
  
  protected
  
  # Cancan example
  def ckeditor_authenticate
    authorize! :index, @asset
    authorize! :create, @asset
    authorize! :destroy, @asset
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
