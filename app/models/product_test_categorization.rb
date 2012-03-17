# -*- encoding : utf-8 -*-
class ProductTestCategorization < ActiveRecord::Base
  belongs_to :product_test
  belongs_to :category
end
