# -*- encoding : utf-8 -*-
class PresentationPicture < ActiveRecord::Base
  belongs_to :presentation_picturable, :polymorphic => true
  belongs_to :user
  
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => '/images/post_picture_missing.png',
       :storage => :s3,
       :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
       :path => "/presentation_pictures/:id/:style/:filename",
       :url  => ":s3_eu_url"
  attr_accessible :picture
  attr_accessor :picture_url
  
  public
  
  def attach(object)
    self.presentation_picturable_id = object.id            # We attach picture to tip
    self.presentation_picturable_type = object.class.to_s
    self.save
  end
end