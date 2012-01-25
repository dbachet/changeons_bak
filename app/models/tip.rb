class Tip < ActiveRecord::Base
  belongs_to :user
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  has_many :tip_categorizations
  has_many :categories, :through => :tip_categorizations
  
  validates_uniqueness_of :title
  validates_presence_of :title, :description, :category_ids 
end
