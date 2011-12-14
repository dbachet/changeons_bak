class NewsletterSubscribersController < AuthorizedController
  
  respond_to :html, :only => [:index, :edit, :create]
  respond_to :js, :only => [:update, :destroy]
  
  # GET /newsletter_subscribers
  # GET /newsletter_subscribers.xml
  def index
    @newsletter_subscribers = NewsletterSubscriber.all

    respond_with do |format|
      format.html { render :index, :layout => false }
    end
  end

  # GET /newsletter_subscribers/1
  # GET /newsletter_subscribers/1.xml
  # def show
  #   @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @newsletter_subscriber }
  #   end
  # end

  # GET /newsletter_subscribers/new
  # GET /newsletter_subscribers/new.xml
  # def new
  #   @newsletter_subscriber = NewsletterSubscriber.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @newsletter_subscriber }
  #   end
  # end

  # GET /newsletter_subscribers/1/edit
  def edit
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
    
    respond_with do |format|
      format.html { render :edit, :layout => false }
    end
  end

  # POST /newsletter_subscribers
  # POST /newsletter_subscribers.xml
  def create
    @newsletter_subscriber = NewsletterSubscriber.new(params[:newsletter_subscriber])

    respond_with do |format|
      if @newsletter_subscriber.save
        format.html { redirect_to(root_path, :notice => 'Newsletter subscriber was successfully created.') }
      else
        format.html { redirect_to(root_path, :notice => 'Newsletter subscriber was NOT successfully created.') }
      end
    end
  end

  # PUT /newsletter_subscribers/1
  # PUT /newsletter_subscribers/1.xml
  def update
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])

    
    respond_with do |format|
      if @newsletter_subscriber.update_attributes(params[:newsletter_subscriber])
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /newsletter_subscribers/1
  # DELETE /newsletter_subscribers/1.xml
  def destroy
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
    @newsletter_subscriber.destroy

    respond_with
  end
end
