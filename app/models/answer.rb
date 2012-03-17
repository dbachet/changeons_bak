# -*- encoding : utf-8 -*-
class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  
  acts_as_voteable
  
end
