class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :post_type
  
  has_many :comments
  has_friendly_id :title, :use_slug => true
  
  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  attr_accessible :category_ids, :post_type_id, :title, :content

end
