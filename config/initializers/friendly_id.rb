# enables the friendly_id for the tag model inherited from gem ActsAsTaggableOn
ActsAsTaggableOn::Tag.has_friendly_id :name, :use_slug => true, :approximate_ascii => true