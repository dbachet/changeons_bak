class ProductTest < ActiveRecord::Base
  belongs_to :user
  
  has_friendly_id :brand_and_product_model, :use_slug => true, :approximate_ascii => true

  def brand_and_product_model
    "#{brand} #{product_model}"
  end
  
  # has_many :tip_categorizations
  # has_many :categories, :through => :tip_categorizations
end
