# -*- encoding : utf-8 -*-
class PresentationPicture < ActiveRecord::Base
  belongs_to :presentation_picturable, :polymorphic => true
  belongs_to :user
  
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => '/images/post_picture_missing.png'
  attr_accessible :picture
  attr_accessor :picture_url
end
