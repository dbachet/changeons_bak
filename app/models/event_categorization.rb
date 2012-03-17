# -*- encoding : utf-8 -*-
class EventCategorization < ActiveRecord::Base
  belongs_to :event
  belongs_to :category
end
