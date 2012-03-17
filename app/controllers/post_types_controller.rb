# -*- encoding : utf-8 -*-
class PostTypesController < AuthorizedController
  layout false, :only => :new
  before_filter :authenticate_user!
  respond_to :html, :only => [:index, :new, :edit]
  respond_to :js, :only => [:create, :update, :destroy]
  
  # GET /post_types
  # GET /post_types.xml
  def index
    @post_types = PostType.all

    respond_with
  end

  # GET /post_types/1
  # GET /post_types/1.xml
  # def show
  #   @post_type = PostType.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @post_type }
  #   end
  # end

  # GET /post_types/new
  # GET /post_types/new.xml
  def new
    @post_type = PostType.new

    respond_with
  end

  # GET /post_types/1/edit
  def edit
    @post_type = PostType.find(params[:id])
  end

  # POST /post_types
  # POST /post_types.xml
  def create
    @post_type = PostType.new(params[:post_type])

    respond_with do |format|
      if @post_type.save
        format.js
        # format.html { redirect_to(@post_type, :notice => 'Post type was successfully created.') }
      else
        format.js
        # format.html { render :action => "new" }
      end
    end
  end

  # PUT /post_types/1
  # PUT /post_types/1.xml
  def update
    @post_type = PostType.find(params[:id])

    respond_with do |format|
      if @post_type.update_attributes(params[:post_type])
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /post_types/1
  # DELETE /post_types/1.xml
  def destroy
    @post_type = PostType.find(params[:id])
    @post_type.destroy

    respond_with
  end
end
