class TagsController < AuthorizedController
  
  def show_posts
    @tag = Tag.find(params[:tag_id])
    @posts = Post.tagged_with(@tag.name)
  end
end