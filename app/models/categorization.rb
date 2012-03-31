# -*- encoding : utf-8 -*-
class Categorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :categorizable, :polymorphic => true
end
