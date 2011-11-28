class Comment < ActiveRecord::Base
  scope :recent, order('created_at desc').limit(APP_CONFIG['default_comment_offset'])
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]
  
  validates_presence_of :body
  validates_presence_of :user, :unless => :written_as_guest?
  validates_presence_of :guest_email, :guest_website, :if => :written_as_guest?
  
  # NOTE: install the acts_as_votable plugin if you 
  # want user to vote on the quality of comments.
  #acts_as_voteable
  
  # NOTE: Comments belong to a user
  belongs_to :user
  belongs_to :post
  
  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, comment, title)
    c = self.new
    c.commentable_id = obj.id
    c.commentable_type = obj.class.name
    c.body = comment
    c.title = title
    c.user_id = user_id
    c.guest_email = nil
    c.guest_website = nil
    c
  end
  
  def self.build_from_as_guest(obj, comment, title, guest_email, guest_website)
    c = self.new
    c.commentable_id = obj.id 
    c.commentable_type = obj.class.name 
    c.body = comment
    c.title = title
    c.user_id = -1 # user_id defined for guest
    c.guest_email = guest_email
    c.guest_website = guest_website
    c
  end
  
  #helper method to check if a comment has children
  def has_children?
    self.children.size > 0 
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
  
  # sort as {1=>[#<Comment>, #<Comment>], 8=>[#<Comment>]} where the first comment of each array is the root comment
  def self.fetch_comments(post, offset)
    comments = post.root_comments.recent.offset(offset)
    
    hash = {}
    comments.each do |comment|
      hash[comment.id] = [comment]
      if comment.has_children?
        comment.children.each do |child| # Add recent scope
          hash[comment.id] << child
        end
      end
    end
    
    hash
  end
end
