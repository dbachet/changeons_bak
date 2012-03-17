# -*- encoding : utf-8 -*-
class ContactForm
  include ActiveModel::Validations 
  include ActiveModel::Conversion
  
  attr_accessor :name, :email, :body 
  validates_presence_of :name, :email, :body
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  def initialize(attributes = {}) 
    attributes.each do |name, value| 
      send("#{name}=", value) 
    end 
  end
  
  def persisted? 
    false 
  end
end 
