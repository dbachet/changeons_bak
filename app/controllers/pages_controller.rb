class PagesController < AuthorizedController
  skip_load_and_authorize_resource
  
  def home
  end

  def contact
  end

  def search
    authorize! :search, :pages
  end
  
  def admin
    authorize! :admin, :admin_page
  end
  
  def about
    authorize! :about, :pages
  end
  
  def tips
    authorize! :tips, :pages
  end
end
