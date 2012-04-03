# -*- encoding : utf-8 -*-
class Question < ActiveRecord::Base
  scope :recent, order('created_at desc')
  delegate :picture, :to => :presentation_picture, :allow_nil => true
  
  has_many :answers
  
  acts_as_voteable
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  belongs_to :user
  
  has_many :categorizations, :as => :categorizable
  has_many :categories, :through => :categorizations
  accepts_nested_attributes_for :categories
  
  attr_accessible :category_ids, :categories_attributes, :title, :content, :presentation_picture_id, :source_description, :source, :sources
  
  has_one :presentation_picture, :as => :presentation_picturable, :dependent => :destroy
  accepts_nested_attributes_for :presentation_picture, :allow_destroy => true
  
  attr_accessor :source_description, :source, :presentation_picture_id
  
  validates_uniqueness_of :title
  validates_presence_of :title, :category_ids
  validates_length_of :title, :maximum => 100
  validates_length_of :source_description, :maximum => 80
  
  
end
