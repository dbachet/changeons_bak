# -*- encoding : utf-8 -*-
class ProductTest < ActiveRecord::Base
  scope :published, joins(:moderation_setting).where("moderation_settings.published = ?", true)
  scope :recent, order('created_at desc')
  delegate :picture, :to => :presentation_picture, :allow_nil => true
  
  delegate :approve, :refuse, :pending_for_moderation, :to => :moderation_setting, :allow_nil => true
  delegate :published, :to => :moderation_setting, :allow_nil => true, :prefix => :is
  delegate :moderated, :to => :moderation_setting, :allow_nil => true, :prefix => :was
  
  belongs_to :user
  
  acts_as_commentable
  acts_as_voteable
  
  has_friendly_id :brand_and_product_model, :use_slug => true, :approximate_ascii => true
  # has_attached_file :picture, :styles => Proc.new { |clip| clip.instance.attachment_sizes }, :default_url => '/images/post_picture_missing.png'
  
  # validates_attachment_size :picture, :less_than => 2.megabytes
  # validates_attachment_content_type :picture, :content_type => [ /^image\/(?:jpeg|gif|png)$/, nil ]
  
  def brand_and_product_model
    "#{brand} #{product_model}"
  end
  
  has_many :comments
  
  has_one :presentation_picture, :as => :presentation_picturable, :dependent => :destroy
  has_one :moderation_setting, :as => :moderatable, :dependent => :destroy
  # accepts_nested_attributes_for :presentation_picture, :allow_destroy => true
  
  has_many :categorizations, :as => :categorizable
  has_many :categories, :through => :categorizations
  accepts_nested_attributes_for :categories
  
  attr_accessible :certifying_organization, :certifying_organization_identifier, :category_ids, :categories_attributes, :brand, :product_model, :product_ref, :description, :recommended_price, :mark, :presentation_picture_id, :opinion, :advantages, :advantage, :drawbacks, :drawback, :source_description, :source, :sources
  
  attr_accessor :advantage, :advantages_preview, :drawback, :drawbacks_preview, :presentation_picture_id
  
  validates_length_of :brand, :maximum => 50
  validates_length_of :source_description, :maximum => 80
  validates_length_of :product_model, :maximum => 80
  validates_format_of :recommended_price, :with => /\A\d*(\.\d{1,2})?\Z/, :allow_blank => true
  validates_numericality_of :mark, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5
  
  # validates_numericality_of :recommended_price, :greater_than_or_equal_to => 0.00,
  #                                                   :less_than_or_equal_to => 99000.99,
  #                                                   :if => Proc.new {|p| p.recommended_price.blank?}
  
  validates_presence_of :product_model, :description, :opinion, :category_ids, :mark
  # validate :file_dimensions, :unless => "errors.any?"
  
  attr_accessor :source_description, :source
  
  def attachment_sizes
    if self.picture_orientation_horizontal
       size =  { :medium => "300x", :thumb => "50x50>" }
    else
       size =  { :medium => "200x", :thumb => "50x50>" }
    end
    size
  end
  
  private
  
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
