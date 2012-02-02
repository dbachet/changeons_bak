class UploadPicture < ActiveRecord::Base
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => '/images/post_picture_missing.png'
  attr_accessible :picture
  attr_accessor :picture_url
end
