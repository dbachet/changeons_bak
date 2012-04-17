# -*- encoding : utf-8 -*-
class ModerationSetting < ActiveRecord::Base
  belongs_to :moderatable, :polymorphic => true
  # attr_accessible :published, :moderated
  
  
  private
  
    def approve
      self.moderated = true
      self.published = true
      self.save
    end
    
    def refuse
      self.moderated = true
      self.published = false
      self.save
    end
    
    def pending_for_moderation
      self.moderated = false
      self.save
    end
    
end