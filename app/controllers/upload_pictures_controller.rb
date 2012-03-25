# -*- encoding : utf-8 -*-
class UploadPicturesController < ApplicationController
  # GET /upload_pictures
  # GET /upload_pictures.xml
  def index
    @upload_pictures = UploadPicture.all
    @upload_picture = UploadPicture.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @upload_pictures }
    end
  end

  # GET /upload_pictures/1
  # GET /upload_pictures/1.xml
  def show
    @upload_picture = UploadPicture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upload_picture }
    end
  end

  # GET /upload_pictures/new
  # GET /upload_pictures/new.xml
  def new
    @upload_picture = UploadPicture.new

    respond_to do |format|
      format.html { render :new, :layout => false}
      format.xml  { render :xml => @upload_picture }
    end
  end

  # GET /upload_pictures/1/edit
  def edit
    @upload_picture = UploadPicture.find(params[:id])
  end

  # POST /upload_pictures
  # POST /upload_pictures.xml
  def create
    @upload_picture = UploadPicture.create(params[:upload_picture])

    respond_to do |format|
      if @upload_picture.save
        # format.json { render :json => [{ :name => @upload_picture.picture_file_name, :size => @upload_picture.picture_file_size, :url => @upload_picture.picture.url, :thumbnail_url => @upload_picture.picture.url(:thumb), :delete_url => "", :delete_type => "" }] }
        format.html { redirect_to(@upload_picture, :notice => 'Upload picture was successfully created.') }
                        format.xml  { render :xml => @upload_picture, :status => :created, :location => @upload_picture }
      else
        # format.html { render :action => "new" }
        # format.xml  { render :xml => @upload_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /upload_pictures/1
  # PUT /upload_pictures/1.xml
  def update
    @upload_picture = UploadPicture.find(params[:id])

    respond_to do |format|
      if @upload_picture.update_attributes(params[:upload_picture])
        format.html { redirect_to(@upload_picture, :notice => 'Upload picture was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /upload_pictures/1
  # DELETE /upload_pictures/1.xml
  def destroy
    @upload_picture = UploadPicture.find(params[:id])
    @upload_picture.destroy

    respond_to do |format|
      format.html { redirect_to(upload_pictures_url) }
      format.xml  { head :ok }
    end
  end
end
