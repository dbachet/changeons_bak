class Post < ActiveRecord::Base
  scope :recent, order('created_at desc')
  
  acts_as_taggable_on :tags
  acts_as_voteable
  acts_as_commentable
  
  belongs_to :user
  belongs_to :post_type
  
  has_attached_file :picture, :styles => Proc.new { |clip| clip.instance.attachment_sizes }, :default_url => '/images/post_picture_missing.png'
  # missing_:style.png
  has_many :comments
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  attr_accessible :category_ids, :post_type_id, :title, :content, :short_description, :picture, :width, :height, :sources
  
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 2.megabytes
  validates_attachment_content_type :picture, :content_type => [ /^image\/(?:jpeg|gif|png)$/, nil ]
  validates_presence_of :title, :content, :category_ids, :tag_list, :short_description
  validates_length_of :title, :maximum => 100
  validates_length_of :short_description, :maximum => 200
  validates_length_of :source_description, :maximum => 80
  validate :file_dimensions, :unless => "errors.any?"
  
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
