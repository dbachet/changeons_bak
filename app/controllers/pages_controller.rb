class PagesController < AuthorizedController
  skip_load_and_authorize_resource
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  
  def home
    @default_post_offset = APP_CONFIG['default_post_offset']
    @posts = Post.recent.limit(5)
    @tips = Tip.recent.limit(3)
    @questions = Question.recent.limit(3)
    @top_tips = Tip.recent.limit(3)
    @events = Event.recent.limit(3)
    @product_tests = ProductTest.recent.limit(3)
    @top_posts = Post.recent.limit(5)
    @top_product_tests = ProductTest.recent.limit(3)
    
    
  
    @tags =  ActsAsTaggableOn::Tag.all
    
    @displayed_posts = @posts.length
    @remaining_posts = Post.count - @displayed_posts
    
    
    
    puts "#{@changeons_quoi} / #{@changeons_pourquoi}"
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
