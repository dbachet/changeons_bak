class PostTypesController < ApplicationController
  # GET /post_types
  # GET /post_types.xml
  def index
    @post_types = PostType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @post_types }
    end
  end

  # GET /post_types/1
  # GET /post_types/1.xml
  def show
    @post_type = PostType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post_type }
    end
  end

  # GET /post_types/new
  # GET /post_types/new.xml
  def new
    @post_type = PostType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post_type }
    end
  end

  # GET /post_types/1/edit
  def edit
    @post_type = PostType.find(params[:id])
  end

  # POST /post_types
  # POST /post_types.xml
  def create
    @post_type = PostType.new(params[:post_type])

    respond_to do |format|
      if @post_type.save
        format.html { redirect_to(@post_type, :notice => 'Post type was successfully created.') }
        format.xml  { render :xml => @post_type, :status => :created, :location => @post_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /post_types/1
  # PUT /post_types/1.xml
  def update
    @post_type = PostType.find(params[:id])

    respond_to do |format|
      if @post_type.update_attributes(params[:post_type])
        format.html { redirect_to(@post_type, :notice => 'Post type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /post_types/1
  # DELETE /post_types/1.xml
  def destroy
    @post_type = PostType.find(params[:id])
    @post_type.destroy

    respond_to do |format|
      format.html { redirect_to(post_types_url) }
      format.xml  { head :ok }
    end
  end
end
