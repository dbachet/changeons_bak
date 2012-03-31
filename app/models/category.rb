# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true
  
  has_many :categorizations
  has_many :posts, :through => :categorizations, :source => :categorizable, :source_type => 'Post'
  has_many :tips, :through => :categorizations, :source => :categorizable, :source_type => 'Tip'
  has_many :events, :through => :categorizations, :source => :categorizable, :source_type => 'Event'
  has_many :product_tests, :through => :categorizations, :source => :categorizable, :source_type => 'ProductTest'
  has_many :questions, :through => :categorizations, :source => :categorizable, :source_type => 'Question'
    
    
  # has_many :posts, :through => :categorizations
  # 
  # has_many :tip_categorizations
  # has_many :tips, :through => :tip_categorizations
  # 
  # has_many :event_categorizations
  # has_many :events, :through => :event_categorizations
  # 
  # has_many :product_test_categorizations
  # has_many :product_tests, :through => :product_test_categorizations
  # 
  # has_many :question_categorizations
  # has_many :questions, :through => :question_categorizations
  
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

end
