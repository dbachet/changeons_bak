# -*- encoding : utf-8 -*-
class ModerationSettingsController < AuthorizedController
  
  respond_to :js , :only => [:approve, :refuse]
  respond_to :html, :only => :refuse_form
  
  def approve
    @moderatable = moderatable_object
    if !@moderatable.nil?
      puts "test: #{@moderatable.approve}"
    end
    respond_with
  end
  
  def refuse
    @moderatable = moderatable_object
    
    if !@moderatable.nil?
      @moderation_setting = @moderatable.moderation_setting
      if @moderation_setting.update_attributes(params[:moderation_setting])
        
        @moderatable.refuse(params[:moderation_setting][:refuse_cause])
        
        respond_with
      end
      
    end
  end
  
  def refuse_form
    @moderatable = moderatable_object
    @moderation_setting = @moderatable.moderation_setting
    
    respond_with do |format|
      format.html { render :layout => false }
    end
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