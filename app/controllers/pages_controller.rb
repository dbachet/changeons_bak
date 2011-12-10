class PagesController < AuthorizedController
  skip_load_and_authorize_resource
  
  def home
  end

  def contact
  end

  def search
  end
  
  def admin
    authorize! :admin, :admin_page
  end
end
