class Type < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  
  has_many :typizations
  has_many :posts, :through => :typizations
end
