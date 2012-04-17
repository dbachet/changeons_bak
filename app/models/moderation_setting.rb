# -*- encoding : utf-8 -*-
class ModerationSetting < ActiveRecord::Base
  belongs_to :moderatable, :polymorphic => true
  attr_accessible :published, :moderated, :refuse_cause
  
  validates_presence_of :refuse_cause
  
  
  private
  
    def approve
      self.moderated = true
      self.published = true
      self.refuse_cause = ""
      self.save(:validate => false)
    end
    
    def refuse(refuse_cause)
      self.moderated = true
      self.published = false
      self.refuse_cause = refuse_cause
      self.save
    end
    
    def pending_for_moderation
      self.moderated = false
      self.save
    end
    
end