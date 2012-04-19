# -*- encoding : utf-8 -*-
class Avatar < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :avatar, :styles => { :medium => "120x120#", :thumb => "50x50#" }, :default_url => 'post_picture_missing.png',
       :storage => :s3,
       :s3_credentials => Rails.root.join("config/aws.yml"),
       # :s3_credentials => Rails.root.join("config/s3.yml"),
       :path => "/avatars/:id/:style/:filename",
       :url  => ":s3_eu_url"

  attr_accessible :avatar
  attr_accessor :avatar_url
  
end
