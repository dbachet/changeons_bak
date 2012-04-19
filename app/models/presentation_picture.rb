# -*- encoding : utf-8 -*-
class PresentationPicture < ActiveRecord::Base
  belongs_to :presentation_picturable, :polymorphic => true
  belongs_to :user
  
  has_attached_file :picture, :styles => { :medium => "435x435>", :thumb => "50x50#" }, :default_url => 'post_picture_missing.png',
       :storage => :s3,
       :s3_credentials => Rails.root.join("config/aws.yml"),
       # :s3_credentials => Rails.root.join("config/s3.yml"),
       :path => "/presentation_pictures/:id/:style/:filename",
       :url  => ":s3_eu_url"

  attr_accessible :picture
  attr_accessor :picture_url
  
  public
  
  def authenticated_url(style = nil, expires_in = 90.minutes)
    attachment.s3_object(style).url_for(:read, :secure => true, :expires => expires_in).to_s
  end
  
  def attach(object)
    self.presentation_picturable_id = object.id            # We attach picture to object
    self.presentation_picturable_type = object.class.to_s
    self.save
  end
end
