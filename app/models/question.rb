class Question < ActiveRecord::Base
  has_many :answers
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  
end
