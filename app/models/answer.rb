# -*- encoding : utf-8 -*-
class Answer < ActiveRecord::Base
  scope :published, joins(:moderation_setting).where("moderation_settings.published = ?", true)
  scope :recent, order('created_at desc')
  
  delegate :approve, :refuse, :pending_for_moderation, :to => :moderation_setting, :allow_nil => true
  delegate :published, :to => :moderation_setting, :allow_nil => true, :prefix => :is
  delegate :moderated, :to => :moderation_setting, :allow_nil => true, :prefix => :was
  
  has_one :moderation_setting, :as => :moderatable, :dependent => :destroy
  
  belongs_to :question
  belongs_to :user
  
  attr_accessible :content
  
  validates_presence_of :content
  
  acts_as_voteable
  
end
