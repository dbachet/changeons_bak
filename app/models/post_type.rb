# -*- encoding : utf-8 -*-
class PostType < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true
  
  has_many :posts
  
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name
end
