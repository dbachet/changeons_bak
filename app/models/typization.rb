class Typization < ActiveRecord::Base
  belongs_to :post
  belongs_to :type
end
