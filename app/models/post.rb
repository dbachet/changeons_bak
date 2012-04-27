# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  scope :published, joins(:moderation_setting).where("moderation_settings.published = ?", true)
  scope :recent, order('created_at desc')
  scope :member_of_redaction, joins(:user).where("user.role = ? OR user.role = ?", "admin", "redactor")
  delegate :picture, :to => :presentation_picture, :allow_nil => true
  
  delegate :approve, :refuse, :pending_for_moderation, :to => :moderation_setting, :allow_nil => true
  delegate :published, :to => :moderation_setting, :allow_nil => true, :prefix => :is
  delegate :moderated, :to => :moderation_setting, :allow_nil => true, :prefix => :was
  
  acts_as_taggable_on :tags
  acts_as_voteable
  acts_as_commentable
  
  belongs_to :user
  belongs_to :post_type
  
  # has_attached_file :picture, :styles => Proc.new { |clip| clip.instance.attachment_sizes }, :default_url => '/images/post_picture_missing.png'
  
  # missing_:style.png
  has_many :comments
  
  has_one :presentation_picture, :as => :presentation_picturable, :dependent => :destroy
  has_one :moderation_setting, :as => :moderatable, :dependent => :destroy
  # accepts_nested_attributes_for :moderation_setting, :allow_destroy => true
  # accepts_nested_attributes_for :presentation_picture, :allow_destroy => true
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  has_many :categorizations, :as => :categorizable
  has_many :categories, :through => :categorizations, :dependent => :destroy
  accepts_nested_attributes_for :categories
  
  
  attr_accessible :presentation_picture_text, :category_ids, :post_type_id, :title, :content, :short_description, :picture, :width, :height, :sources, :categories_attributes, :presentation_picture_id, :source_description, :source, :tag_list
  
  # validates_attachment_presence :picture
  # validates_attachment_size :picture, :less_than => 2.megabytes
  # validates_attachment_content_type :picture, :content_type => [ /^image\/(?:jpeg|gif|png)$/, nil ]
  validates_presence_of :title, :content, :tag_list, :short_description, :category_ids
  validates_length_of :title, :maximum => 100
  validates_length_of :short_description, :maximum => 200
  validates_length_of :source_description, :maximum => 80
  # validate :file_dimensions, :unless => "errors.any?"
  
  attr_accessor :source_description, :source, :presentation_picture_id
  
  def attachment_sizes
    if self.picture_orientation_horizontal
       size =  { :medium => "300x", :thumb => "50x50>" }
    else
       size =  { :medium => "200x", :thumb => "50x50>" }
    end
    size
  end
  
  # def self.title
  #   # find all records, then map name attributes to an array
  #   find(:all, :select => ["title", "id"])
  # end
  
  private
  
  def file_dimensions
    dimensions = Paperclip::Geometry.from_file(picture.to_file(:original))
    self.picture_width = dimensions.width
    self.picture_height = dimensions.height
    
    if (self.picture_height / self.picture_width) == 1
      self.picture_orientation_horizontal = false
    else
      self.picture_orientation_horizontal = true
    end
    
    if dimensions.width < 300 && dimensions.height < 300
      errors.add(:picture,'La hauteur et la largeur de l\'image doivent être d\'au moins 300px')
      self.has_big_picture = false
    else
      self.has_big_picture = true
    end
  end
end
