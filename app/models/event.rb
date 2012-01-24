class Event < ActiveRecord::Base
  belongs_to :user
  
  has_friendly_id :title, :use_slug => true
  
  has_many :event_categorizations
  has_many :categories, :through => :event_categorizations
  
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :event_date, :category_ids
end
