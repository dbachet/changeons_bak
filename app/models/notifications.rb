class Notifications < ActionMailer::Base
  default :to => "admin@changeons.org", :from => "admin@changeons.org"
  
  def contact_us(contact_form)
    @sender_name = contact_form.name
    @sender_email = contact_form.email
    @sender_body = contact_form.body
    mail(:from => contact_form.email, :subject => "Contact - Changeons.org")
  end
  
  def send_notification_to_root_comment(reply, root_comment, email_author_root_comment)
    @reply = reply
    @root_comment = root_comment
    @post = Post.find_by_id(root_comment.commentable_id)
    mail(:to => email_author_root_comment, :subject => "Changeons.org - Quelqu'un a répondu à votre commentaire")
  end
end