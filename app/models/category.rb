class Category < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true
  
  has_many :categorizations
  has_many :posts, :through => :categorizations
  
  has_many :tip_categorizations
  has_many :tips, :through => :tip_categorizations
  
  has_many :event_categorizations
  has_many :events, :through => :event_categorizations
  
  has_many :product_test_categorizations
  has_many :product_tests, :through => :product_test_categorizations
  
  has_many :question_categorizations
  has_many :questionss, :through => :question_categorizations
  
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name
end
