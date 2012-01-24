class Tip < ActiveRecord::Base
  belongs_to :user
  
  has_many :tip_categorizations
  has_many :categories, :through => :tip_categorizations
end
