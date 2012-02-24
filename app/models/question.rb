class Question < ActiveRecord::Base
  has_many :answers
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  # belongs_to :user
  has_many :question_categorizations
  has_many :categories, :through => :question_categorizations
end
