class Tip < ActiveRecord::Base
  belongs_to :user
  
  has_friendly_id :title, :use_slug => true
  
  has_many :tip_categorizations
  has_many :categories, :through => :tip_categorizations
end
