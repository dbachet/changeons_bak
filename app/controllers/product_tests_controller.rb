# -*- encoding : utf-8 -*-
class ProductTestsController < AuthorizedController
  include ActionView::Helpers::TextHelper
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  add_breadcrumb "Avis/Tests de produits", :product_tests_path, :title => "Revenir à la liste des avis/tests de produits", :except => %w(index show)
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def add_source
    @page = params[:controller]
    
    respond_to do |format|
      format.js { render 'layouts/add_source'}
    end
  end
  
  def remove_source
    @source = params[:source]
    @page = params[:controller]
    
    respond_to do |format|
      format.js { render 'layouts/remove_source'}
    end
  end
  
  def show_advantage_form_field
    respond_to do |format|
      format.js
    end
  end
  
  def add_advantage
    respond_to do |format|
      format.js
    end
  end
  
  def remove_advantage
    @source = params[:source]
    
    respond_to do |format|
      format.js
    end
  end
  
  def show_drawback_form_field
    respond_to do |format|
      format.js
    end
  end
  
  def add_drawback
    respond_to do |format|
      format.js
    end
  end
  
  def remove_drawback
    @source = params[:source]
    
    respond_to do |format|
      format.js
    end
  end
  
  def vote_up
    begin
      if current_user.voted_for?(@product_test)
        current_user.clear_votes(@product_test)
      else
        current_user.vote_exclusively_for(@product_test)
      end
      @votes_result = @product_test.plusminus
      
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'layouts/vote_up'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  # GET /product_tests
  # GET /product_tests.xml
  def index
    
    
    if params[:category_id]                                                     # TO CHANGE
      @category = Category.find_by_cached_slug(params[:category_id])
      @product_tests = @category.product_tests.page(params[:page]).per(5)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Avis/Tests de produits", product_tests_from_category_path(@category), :title => "Revenir à la liste des avis/tests de produits"
    else
      add_breadcrumb "Avis/Tests de produits", :product_tests_path, :title => "Revenir à la liste des avis/tests de produits"
      @product_tests = ProductTest.recent.page(params[:page]).per(5)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_tests }
    end
  end

  # GET /product_tests/1
  # GET /product_tests/1.xml
  def show
    @product_test = ProductTest.find(params[:id])
    @user = @product_test.user
    @categories = @product_test.categories
    
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @comment = Comment.new
    @from = 0
    @limitation = @default_comment_offset
    @comments = Comment.fetch_comments(@product_test, @from, 10)
    
    also_to_read_items(@categories)
    
    declare_variables_reply_form_after_login  # if guest fills reply form and logs in, then we have to declare these variables to 
                                              # be able to display reply form
    
    @displayed_comments = @comments.length
    @remaining_comments = @product_test.root_comments.count - @displayed_comments

    @votes_result = @product_test.plusminus
    
    
    accessed_from_this_category = accessed_from_category
    
    if !accessed_from_this_category.nil?                                         # TO CHANGE
      @category = Category.find_by_cached_slug(accessed_from_this_category)
      add_breadcrumb "Catégories", :categories_path, :title => "Revenir à la liste des catégories"
      add_breadcrumb @category.name.camelize, category_path(@category)
      add_breadcrumb "Avis/Tests de produits", product_tests_from_category_path(@category), :title => "Revenir à la liste des avis/tests de produits"
      add_breadcrumb truncate("#{@product_test.brand} #{@product_test.product_model}", :length => 30), :product_test_path
    else
      add_breadcrumb "Avis/Tests de produits", :product_tests_path, :title => "Revenir à la liste des avis/tests de produits"
      add_breadcrumb truncate("#{@product_test.brand} #{@product_test.product_model}", :length => 30), :product_test_path
    end
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_test }
    end
  end

  # GET /product_tests/new
  # GET /product_tests/new.xml
  def new
    @product_test = ProductTest.new
    add_breadcrumb "Nouvel avis/test", :new_product_test_path
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_test }
    end
  end

  # GET /product_tests/1/edit
  def edit
    @product_test = ProductTest.find(params[:id])
    add_breadcrumb truncate("#{@product_test.brand} #{@product_test.product_model}", :length => 20), :product_test_path
    add_breadcrumb "Éditer l'avis/test", :edit_product_test_path
  end

  # POST /product_tests
  # POST /product_tests.xml
  def create
    @product_test = current_user.product_tests.new(params[:product_test])

    respond_to do |format|
      if @product_test.save
        @product_test.category_ids = params[:product_test][:category_ids]
        manage_presentation_picture(@product_test, params[:product_test][:presentation_picture_id])
        format.html { redirect_to(@product_test, :notice => 'Product test was successfully created.') }
        format.xml  { render :xml => @product_test, :status => :created, :location => @product_test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_tests/1
  # PUT /product_tests/1.xml
  def update
    @product_test = ProductTest.find(params[:id])

    respond_to do |format|
      if @product_test.update_attributes(params[:product_test])
        @product_test.category_ids = params[:product_test][:category_ids]
        manage_presentation_picture(@product_test, params[:product_test][:presentation_picture_id])
        format.html { redirect_to(@product_test, :notice => 'Product test was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_tests/1
  # DELETE /product_tests/1.xml
  def destroy
    @product_test = ProductTest.find(params[:id])
    @product_test.destroy

    respond_to do |format|
      format.html { redirect_to(product_tests_url) }
      format.xml  { head :ok }
    end
  end
end
