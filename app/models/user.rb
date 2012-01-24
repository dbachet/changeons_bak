class User < ActiveRecord::Base
  ROLES = %w[user moderator admin]
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :email_regexp =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  attr_accessor :post_id, :root_comment_id, :action, :displayed_comments, :displayed_posts
  
  has_many :posts
  has_many :tips
  has_many :events
  has_many :comments
  
  def role?(role)
    true if self.role == role.to_s
  end
end
