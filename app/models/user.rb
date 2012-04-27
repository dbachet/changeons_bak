# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # before_save :set_default_role, :on => :create
  ROLES = %w[user redactor admin]
  acts_as_voter
  
  delegate :avatar, :to => :avatar, :allow_nil => true, :prefix => :get
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable# , :email_regexp =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  validates :email, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates_confirmation_of :password
  # validates_length_of :password, :minimum => 6, :maximum => 100, :allow_blank => true
  # validates_presence_of :password, :on => :create
  # validates_presence_of :current_password
  # validates_uniqueness_of :email, :on => :create
  
  has_one :avatar, :dependent => :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :display_name, :real_name, :website, :location, :birthday, :about_me, :avatar_id
  attr_accessor :post_id, :root_comment_id, :action, :displayed_comments, :displayed_posts, :stored_comment_title, :stored_comment_body, :stored_reply_title, :stored_reply_body, :scroll_position, :reply_parent_id, :avatar_id
                                                                                             
  has_many :posts                                                       
  has_many :tips                                                                          
  has_many :events
  has_many :product_tests
  has_many :comments
  has_many :questions
  has_many :answers
  has_many :presentation_pictures
  
  def role?(role)
    true if self.role == role.to_s
  end
  
  def member_state
    if self.role?(:admin) || self.role?(:redactor)
      "Membre de la rédaction"
    else
      "Utilisateur"
    end
  end
  
  def is_owner_of_avatar?(current_user)
    if self.avatar.user_id = current_user.id
      true
    end
  end
  
  def member_of_redaction?
    if self.role?(:admin) || self.role?(:redactor)
      true
    else
      false
    end
  end
  
  
  protected
  
  def set_default_role
    puts "controller: #{params[:controller]}"
    if self.role.blank?
      self.role = "user"
    end
  end
end
