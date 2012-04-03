# -*- encoding : utf-8 -*-
class Tip < ActiveRecord::Base
  scope :recent, order('created_at desc')
  delegate :picture, :to => :presentation_picture, :allow_nil => true
  
  belongs_to :user
  # INDEX_COLUMNS = column_names - ['title', 'picture_file_name', 'picture_content_type', 'picture_file_size', 'picture_updated_at']
  
  acts_as_commentable
  acts_as_voteable
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  # has_attached_file :picture, :styles => Proc.new { |clip| clip.instance.attachment_sizes }, :default_url => '/images/post_picture_missing.png'
  
  # validates_attachment_size :picture, :less_than => 2.megabytes
  # validates_attachment_content_type :picture, :content_type => [ /^image\/(?:jpeg|gif|png)$/, nil ]
  
  has_many :comments
  
  has_one :presentation_picture, :as => :presentation_picturable, :dependent => :destroy
  accepts_nested_attributes_for :presentation_picture, :allow_destroy => true
  
  has_many :categorizations, :as => :categorizable
  has_many :categories, :through => :categorizations
  accepts_nested_attributes_for :categories
  
  attr_accessible :category_ids, :categories_attributes
  
  attr_accessor :source_description, :source, :presentation_picture_id
  
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :category_ids
  validates_length_of :title, :maximum => 100
  validates_length_of :source_description, :maximum => 80
  # validate :file_dimensions, :unless => "errors.any?"
    
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
  #   find(:all, :select => "title").map(&:title)
  # end
  
  private
  # needs to accept square picture as horizontal orientation, needs to add a field accepted picture for top if rate (height/width) is higher than ...
  def file_dimensions
    if (picture.to_s <=> "/images/post_picture_missing.png") == 1
      dimensions = Paperclip::Geometry.from_file(picture.to_file(:original))
      self.picture_width = dimensions.width
      self.picture_height = dimensions.height
      
      if (self.picture_height / self.picture_width) == 1
        self.picture_orientation_horizontal = false
      else
        self.picture_orientation_horizontal = true
      end
      
      if dimensions.width < 300 && dimensions.height < 300
        self.has_big_picture = false
      else
        self.has_big_picture = true
      end
    end
  end
end
