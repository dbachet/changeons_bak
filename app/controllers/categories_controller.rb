class CategoriesController < AuthorizedController
   before_filter :authenticate_user!, :except => [:show]
   respond_to :html, :only => [:index, :new, :edit, :show]
   respond_to :js, :only => [:create, :update, :destroy]
   
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all

    respond_with do |format|
      format.html { render :index, :layout => false}
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])
  
    respond_with
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new
    respond_with do |format|
      format.html { render :new, :layout => false}
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_with do |format|
      if @category.save
        format.js
        # format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
      else
        format.js
        # format.html { render :action => "new" }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_with do |format|
      if @category.update_attributes(params[:category])
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_with
  end
end
