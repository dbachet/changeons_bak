# -*- encoding : utf-8 -*-
class TipCategorization < ActiveRecord::Base
  belongs_to :tip
  belongs_to :category
end
