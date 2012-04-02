# -*- encoding : utf-8 -*-
class TagsController < AuthorizedController
  add_breadcrumb ("<div class='home_breadcrumbs'></div>").html_safe, :root_path, :title => "Revenir en page d'accueil"
  
  def show_posts
    @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
    @posts = Post.tagged_with(@tag.name).page(params[:page]).per(5)
    add_breadcrumb "Recherche par tag \"#{@tag.name}\"", ""
  end
end
