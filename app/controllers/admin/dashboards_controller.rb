class Admin::DashboardsController < AuthorizedController
  skip_load_and_authorize_resource
  # layout false, :only => :user_index
  respond_to :html
  
  def index
    authorize! :index, :admin_dashboard
  end
  
  def user_index
    @users = User.all
    authorize! :user_index, :admin_dashboard
    
    respond_with do |format|
      format.html { render :user_index, :layout => false}
    end
  end
end