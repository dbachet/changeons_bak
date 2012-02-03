class Event < ActiveRecord::Base
  belongs_to :user
  
  acts_as_commentable
  acts_as_voteable
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => '/images/post_picture_missing.png'
  
  has_many :comments
  
  has_many :event_categorizations
  has_many :categories, :through => :event_categorizations
  
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :event_start_date, :category_ids
end
