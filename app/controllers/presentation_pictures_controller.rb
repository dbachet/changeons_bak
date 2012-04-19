# -*- encoding : utf-8 -*-
class PresentationPicturesController < AuthorizedController
  respond_to :html, :only => :new
  respond_to :js, :only => [:create, :destroy]
  
  def new
    @presentation_picture = PresentationPicture.new
    
    respond_to do |format|
      format.html { render :new, :layout => false}
    end
  end
  
  def create
    
    @presentation_picture = current_user.presentation_pictures.create(params[:presentation_picture])

    
    if @presentation_picture.save
      respond_with
    end
    
    # respond_with do |format|
    #   if @presentation_picture.save
    #     puts "Should get out as js, shit!"
    #     format.js { render :create }
    #     # format.json { render :json => [{ :name => @upload_picture.picture_file_name, :size => @upload_picture.picture_file_size, :url => @upload_picture.picture.url, :thumbnail_url => @upload_picture.picture.url(:thumb), :delete_url => "", :delete_type => "" }] }
    #     # format.html { redirect_to(@presentation_picture, :notice => 'presenation picture picture was successfully created.') }
    #   else
    #     # format.html { render :action => "new" }
    #     # format.xml  { render :xml => @upload_picture.errors, :status => :unprocessable_entity }
    #   end
    # end
  end
  
  def destroy
    @presentation_picture = PresentationPicture.new
    respond_with
  end
end