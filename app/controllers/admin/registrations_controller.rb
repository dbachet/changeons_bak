class Admin::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication
  # before_filter :signed_in_as_admin?
  layout false, :only => :new
  # authorize_resource :class => false
  
  rescue_from CanCan::AccessDenied do |exception|
   flash[:error] = exception.message
   redirect_to root_url
  end
  
  respond_to :html, :only => [:new, :edit]
  respond_to :js, :only => [:create, :update]
  
  def new
    @user = User.new
    
    
    authorize! :new, :admin_registration
    
    respond_with do |format|
      format.html { render :new }
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    @user.skip_confirmation!
    
    if @user.save
      flash[:notice] = 'User was successfully created.'
      # redirect_to(admin_page_path, :notice => 'User item was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def index
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      # redirect_to(root_path, :notice => 'User item was successfully updated.')
    else
      render :action => "edit"
    end
  end

end