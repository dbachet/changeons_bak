class Notifications < ActionMailer::Base
  default :to => "admin@changeons.org", :from => "admin@changeons.org"
  
  def contact_us(contact_form)
    @sender_name = contact_form.name
    @sender_email = contact_form.email
    @sender_body = contact_form.body
    mail(:from => contact_form.email, :subject => "Contact - Changeons.org")
  end
end