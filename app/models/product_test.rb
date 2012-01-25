class ProductTest < ActiveRecord::Base
  belongs_to :user
  
  has_friendly_id :brand_and_product_model, :use_slug => true, :approximate_ascii => true

  def brand_and_product_model
    "#{brand} #{product_model}"
  end
  
  has_many :product_test_categorizations
  has_many :categories, :through => :product_test_categorizations
  
  validates_format_of :recommended_price, :with => /\A\d*(\.\d{1,2})?\Z/, :allow_blank => true
  
  # validates_numericality_of :recommended_price, :greater_than_or_equal_to => 0.00,
  #                                                   :less_than_or_equal_to => 99000.99,
  #                                                   :if => Proc.new {|p| p.recommended_price.blank?}
  
  validates_presence_of :product_model, :description, :opinion, :category_ids 
end
