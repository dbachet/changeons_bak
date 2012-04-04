# -*- encoding : utf-8 -*-
class VotesController < AuthorizedController
  
  def vote_up
    @vote_parent_object = vote_parent_object
    begin
      if current_user.voted_for?(@vote_parent_object)
        current_user.clear_votes(@vote_parent_object)
      else
        current_user.vote_exclusively_for(@vote_parent_object)
      end
      @votes_result = @vote_parent_object.plusminus
      
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'layouts/vote_up'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def vote_down
    @vote_parent_object = vote_parent_object
    begin
      if current_user.voted_against?(@vote_parent_object)
        current_user.clear_votes(@vote_parent_object)
      else
        current_user.vote_exclusively_against(@vote_parent_object)
      end
      @votes_result = @vote_parent_object.plusminus
      
      # authorize! :vote_down, @post
      
      respond_to do |format|
        format.js
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  private
  
    def vote_parent_object
      case
        when params[:voteable_type] == "post" then Post.find(params[:voteable_id])
        when params[:voteable_type] == "tip" then Tip.find(params[:voteable_id])
        when params[:voteable_type] == "event" then Event.find(params[:voteable_id])
        when params[:voteable_type] == "product_test" then ProductTest.find(params[:voteable_id])
        when params[:voteable_type] == "question" then Question.find(params[:voteable_id])
      end    
    end
end