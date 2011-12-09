class Admin::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!
  layout false, :only => :new
  
  respond_to :html, :only => [:new]
  
  def new
    @user = User.new
    
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
    
    if @user
      flash[:notice] = 'User was successfully created.'
      # redirect_to(admin_page_path, :notice => 'User item was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      redirect_to(root_path, :notice => 'User item was successfully updated.')
    else
      render :action => "edit"
    end
  end

end