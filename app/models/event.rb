# -*- encoding : utf-8 -*-
class Event < ActiveRecord::Base
  scope :recent, order('created_at desc')
  delegate :picture, :to => :presentation_picture, :allow_nil => true
  
  belongs_to :user
  
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
  
  attr_accessible :category_ids, :categories_attributes, :title, :description, :event_start_date, :event_end_date, :presentation_picture_id, :addr_street_1, :addr_street_2, :addr_postcode, :addr_city, :addr_country, :source_description, :source, :sources
  
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :event_start_date, :category_ids
  validates_length_of :title, :maximum => 100
  validates_length_of :addr_street_1, :maximum => 100
  validates_length_of :addr_street_2, :maximum => 100
  validates_length_of :addr_city, :maximum => 50
  validates_length_of :addr_postcode, :maximum => 10
  validates_length_of :source_description, :maximum => 80
  validates_date :event_start_date, :format => "d/m/yyyy"
  validates_date :event_end_date, :on_or_after => :event_start_date, 
                          :on_or_after_message => "La date de fin doit être similaire ou ultérieure à la date de début", 
                          :allow_blank => true, :format => "dd/mm/yyyy"
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
  
  private
  
  def file_dimensions
    if (picture.to_s <=> "post_picture_missing.png") == 1
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
