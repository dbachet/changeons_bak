class Comment < ActiveRecord::Base
  scope :recent, order('created_at desc')
  
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]
  
  validates_presence_of :body, :send_notification_to_root_comment
  validates_presence_of :user, :unless => :written_as_guest?
  validates_presence_of :guest_email, :guest_website, :if => :written_as_guest?
  
  # NOTE: install the acts_as_votable plugin if you 
  # want user to vote on the quality of comments.
  #acts_as_voteable
  
  # NOTE: Comments belong to a user
  belongs_to :user
  belongs_to :post
  belongs_to :tip
  belongs_to :event
  belongs_to :product_test
  
  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, comment, title, send_notification = -1)
    c = self.new
    c.commentable_id = obj.id
    c.commentable_type = obj.class.name
    c.body = comment
    c.title = title
    c.user_id = user_id
    c.guest_email = nil
    c.guest_website = nil
    c.send_notification_to_root_comment = send_notification
    c
  end
  
  def self.build_from_as_guest(obj, comment, title, guest_email, guest_website, send_notification = -1)
    c = self.new
    c.commentable_id = obj.id 
    c.commentable_type = obj.class.name 
    c.body = comment
    c.title = title
    c.user_id = -1 # user_id defined for guest
    c.guest_email = guest_email
    c.guest_website = guest_website
    c.send_notification_to_root_comment = send_notification
    c
  end
  
  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for 
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id 
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end
    
  def written_as_guest?
    if self.user_id == -1
      true
    end
  end
  
  # sort as {1=>[#<Comment>, #<Comment>], 8=>[#<Comment>]} where the key is the id of each root comment
  def self.fetch_comments(post, from = 0, limitation = 0) # from, to
    if limitation > 0
      comments = post.root_comments.recent.offset(from).limit(limitation)
    else
      comments = post.root_comments.recent.offset(from)
    end
    
    fetch_children(comments)
  end
    
  #helper method to check if a comment has children
  def has_children?
    self.children.size > 0 
  end
  
  def is_root_comment?
    self.parent_id.nil?
  end
  
  # Set the comments hash to be able to be used with the helper => display_comments(comments)
  # Set it as fetch_comments method
  def self.set_comment_hash(comment, root_comment = comment)
    hash = {root_comment.id => [comment]}
  end
  
  # Check if the author of the comment wants to receive notifications of the replies
  def self.send_notification_to_root_comment?
    self.send_notification_to_root_comment == 1 ? true : false
  end
  
  def self.send_notification_to_root_comment(root_comment, reply)
    root_comment_author_email = Comment.comment_author_email(root_comment)
    reply_author_email = Comment.comment_author_email(reply)
    
    replier_is_the_root_comment_author = (root_comment_author_email == reply_author_email) ? true : false
    
    if (root_comment_author_email != "unknown") && !replier_is_the_root_comment_author
    # Send a notification to the author of the root comment
    Notifications.send_notification_to_root_comment(reply, root_comment, root_comment_author_email).deliver
    end
  end
  
  def self.is_the_same_author?(comment_1, comment_2)
    comment_1_author_email = Comment.comment_author_email(comment_1)
    comment_2_author_email = Comment.comment_author_email(comment_2)

    (comment_1_author_email == comment_2_author_email) ? true : false
  end
  
  # Returns author email or "unknown" if not found
  def self.comment_author_email(comment)
    
    
    if !comment.guest_email.blank?
      comment.guest_email
    else
      comment_author = User.find_by_id(comment.user_id)
       if !comment_author.nil?
         comment_author.email
       else
          "unknown"
       end
    end
  end
  
  def getUserInfo
    if self.user_id == -1
      user = {:id => -1, :name => "Invité"}
    else
      user = User.find_by_id(self.user_id)
      if user.nil?
        user = {:id => -2, :name => "Profil supprimé"}          
      end
    end
    user
  end
  
  private
  
  def self.fetch_children(comments)
    hash = {}
    comments.each do |comment|
      hash[comment.id] = [comment]
      if comment.has_children?
        comment.children.each do |child|
          hash[comment.id] << child
        end
      end
    end
    
    hash
  end
  

end
