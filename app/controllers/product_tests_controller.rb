class ProductTestsController < AuthorizedController
  before_filter :authenticate_user!, :except => [:index, :show]
  
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
    @product_tests = ProductTest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_tests }
    end
  end

  # GET /product_tests/1
  # GET /product_tests/1.xml
  def show
    @product_test = ProductTest.find(params[:id])
    @categories = @product_test.categories
    
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @comment = Comment.new
    @from = 0
    @limitation = @default_comment_offset
    @comments = Comment.fetch_comments(@product_test, @from, @limitation)
    
    
    
    @displayed_comments = @comments.length
    @remaining_comments = @product_test.root_comments.count - @displayed_comments

    @votes_result = @product_test.plusminus
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_test }
    end
  end

  # GET /product_tests/new
  # GET /product_tests/new.xml
  def new
    @product_test = ProductTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_test }
    end
  end

  # GET /product_tests/1/edit
  def edit
    @product_test = ProductTest.find(params[:id])
  end

  # POST /product_tests
  # POST /product_tests.xml
  def create
    @product_test = current_user.product_tests.new(params[:product_test])

    respond_to do |format|
      if @product_test.save
        @product_test.category_ids = params[:product_test][:category_ids]
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