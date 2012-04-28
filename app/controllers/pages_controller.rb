# -*- encoding : utf-8 -*-
class PagesController < AuthorizedController
  skip_load_and_authorize_resource
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  
  def home
    @last_from_redaction = get_last_from_redaction
    @last_from_redaction_keys = @last_from_redaction.keys.sort
    puts @last_from_redaction_keys
    
    
    @default_post_offset = APP_CONFIG['defaults']['default_post_offset']
    @posts = Post.recent.limit(5)
    @tips = Tip.member_of_redaction.published.recent.limit(3)
    @questions = Question.recent.limit(3)
    @top_tips = Tip.recent.limit(3)
    @events = Event.recent.limit(3)
    @product_tests = ProductTest.recent.limit(3)
    @top_posts = Post.recent.limit(5)
    @top_product_tests = ProductTest.recent.limit(3)
    
    
  
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
