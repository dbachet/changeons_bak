# -*- encoding : utf-8 -*-
class TagsController < AuthorizedController
  
  def show_posts
    @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
    @posts = Post.tagged_with(@tag.name)
  end
end
