class TipsController < AuthorizedController
  
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
  
  def vote_up
    begin
      if current_user.voted_for?(@tip)
        current_user.clear_votes(@tip)
      else
        current_user.vote_exclusively_for(@tip)
      end
      @votes_result = @tip.plusminus
      
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'layouts/vote_up'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  # GET /tips
  # GET /tips.xml
  def index
    @tips = Tip.recent.page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tips }
    end
  end

  # GET /tips/1
  # GET /tips/1.xml
  def show
    @tip = Tip.find(params[:id])
    @categories = @tip.categories
    
    @default_comment_offset = APP_CONFIG['default_post_offset']
    @comment = Comment.new
    @from = 0
    @limitation = @default_comment_offset
    @comments = Comment.fetch_comments(@tip, @from, @limitation)
    
    # puts @tip.categories.first.id
    
    
    also_to_read_items(@categories)
    

    
    @displayed_comments = @comments.length
    @remaining_comments = @tip.root_comments.count - @displayed_comments
    
    
    @votes_result = @tip.plusminus
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tip }
    end
  end

  # GET /tips/new
  # GET /tips/new.xml
  def new
    @tip = Tip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tip }
    end
  end

  # GET /tips/1/edit
  def edit
    @tip = Tip.find(params[:id])
  end

  # POST /tips
  # POST /tips.xml
  def create
    @tip = current_user.tips.new(params[:tip])

    respond_to do |format|
      if @tip.save
        @tip.category_ids = params[:tip][:category_ids]
        format.html { redirect_to(@tip, :notice => 'Tip was successfully created.') }
        format.xml  { render :xml => @tip, :status => :created, :location => @tip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tips/1
  # PUT /tips/1.xml
  def update
    @tip = Tip.find(params[:id])

    respond_to do |format|
      if @tip.update_attributes(params[:tip])
        format.html { redirect_to(@tip, :notice => 'Tip was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.xml
  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy

    respond_to do |format|
      format.html { redirect_to(tips_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
end
