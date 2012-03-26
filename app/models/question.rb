# -*- encoding : utf-8 -*-
class Question < ActiveRecord::Base
  scope :recent, order('created_at desc')
  has_many :answers
  
  acts_as_voteable
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  belongs_to :user
  has_many :question_categorizations
  has_many :categories, :through => :question_categorizations
  
  has_one :presentation_picture, :as => :presentation_picturable, :dependent => :destroy
  accepts_nested_attributes_for :presentation_picture, :allow_destroy => true
  
  attr_accessor :source_description, :source, :presentation_picture_id
  
  validates_uniqueness_of :title
  validates_presence_of :title, :category_ids
  validates_length_of :title, :maximum => 100
  validates_length_of :source_description, :maximum => 80
  
  
end
