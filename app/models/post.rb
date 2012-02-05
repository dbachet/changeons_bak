class Post < ActiveRecord::Base
  scope :recent, order('created_at desc')
  
  acts_as_taggable_on :tags
  acts_as_voteable
  acts_as_commentable
  
  belongs_to :user
  belongs_to :post_type
  
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => '/images/post_picture_missing.png'
  # missing_:style.png
  has_many :comments
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  attr_accessor :post_picture_url
  attr_accessible :category_ids, :post_type_id, :title, :content, :short_description, :picture, :width, :height
  
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 2.megabytes
  validates_attachment_content_type :picture, :content_type => [ /^image\/(?:jpeg|gif|png)$/, nil ]
  validates_presence_of :title, :content, :category_ids, :post_type_id, :tag_list, :short_description
  validate :file_dimensions, :unless => "errors.any?"
  
  private
  
  def file_dimensions
    dimensions = Paperclip::Geometry.from_file(picture.to_file(:original))
    self.picture_width = dimensions.width
    self.picture_height = dimensions.height
    if dimensions.width < 300 && dimensions.height < 300
      errors.add(:picture,'La hauteur et la largeur de l\'image doivent être d\'au moins 300px')
    else
      self.has_big_picture = true
    end
  end
end
