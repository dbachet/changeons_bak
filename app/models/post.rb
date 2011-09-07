class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_friendly_id :title, :use_slug => true
end
