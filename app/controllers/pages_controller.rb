class PagesController < AuthorizedController
  skip_load_and_authorize_resource
  
  def home
    @default_post_offset = APP_CONFIG['default_post_offset']
    @posts = Post.recent.limit(@default_post_offset)
    @tags =  ActsAsTaggableOn::Tag.all
    
    @displayed_posts = @posts.length
    @remaining_posts = Post.count - @displayed_posts
    
    authorize! :home, :pages
    # authorize! :index, @posts_count
    # authorize! :index, @posts
    
    # puts "posts => #{@posts.inspect}"
    
    # TO REFACTOR
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
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
