class Tag < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true
end