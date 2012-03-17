# -*- encoding : utf-8 -*-
class UsersController < AuthorizedController
  def show 
    @user = User.find(params[:id])
    
  end
end
