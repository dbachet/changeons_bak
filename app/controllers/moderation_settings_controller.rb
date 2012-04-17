# -*- encoding : utf-8 -*-
class ModerationSettingsController < ApplicationController
  
  respond_to :js# , :only => :approve
  
  def approve
    @moderatable = moderatable_object
    
    if !@moderatable.nil?
      @moderatable.approve
    end
    
    respond_with
  end
  
  def refuse
    @moderatable = moderatable_object
    
    if !@moderatable.nil?
      @moderatable.refuse
    end
    
    respond_with
  end
  
  
  private
  
    def moderatable_object
      case
        when params[:moderatable_type] == "post" then Post.find(params[:moderatable_id])
        when params[:moderatable_type] == "tip" then Tip.find(params[:moderatable_id])
        when params[:moderatable_type] == "event" then Event.find(params[:moderatable_id])
        when params[:moderatable_type] == "product_test" then ProductTest.find(params[:moderatable_id])
        when params[:moderatable_type] == "question" then Question.find(params[:moderatable_id])
        when params[:moderatable_type] == "comment" then Comment.find(params[:moderatable_id])
        when params[:moderatable_type] == "answer" then Answer.find(params[:moderatable_id])
      end  
    end
end