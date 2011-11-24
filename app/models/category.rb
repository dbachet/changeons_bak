class Category < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  
  has_many :categorizations
  has_many :posts, :through => :categorizations
  
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name
end
