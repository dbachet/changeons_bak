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
  attr_accessible :category_ids, :post_type_id, :title, :content, :short_description, :picture
  
  validates_presence_of :title, :content, :category_ids, :post_type_id, :tag_list, :short_description, :picture
end
