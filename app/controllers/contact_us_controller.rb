# -*- encoding : utf-8 -*-
class ContactUsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def send_email
    @contact_form = ContactForm.new(params[:contact_form])
    
    if @contact_form.valid?
      Notifications.contact_us(@contact_form).deliver 
      redirect_to root_path, :notice => "Email sent, we'll get back to you"
    else
      render :new
    end
    
  end

end
