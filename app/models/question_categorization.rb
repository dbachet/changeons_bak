# -*- encoding : utf-8 -*-
class QuestionCategorization < ActiveRecord::Base
  belongs_to :question
  belongs_to :category
end
