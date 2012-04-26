# -*- encoding : utf-8 -*-
module CommentsHelper
  
  # This is to adapt as the comments maybe will be displayed another way !!
  def display_comments(comments, is_new = false)
    
    if comments.any?
      sorted_keys = comments.keys.sort.reverse
      raw(
      # Display the content of table
        sorted_keys.collect do |root_comment_key|
          # raw(
          content_tag(:div, :class => "root_comment_area #{root_comment_key}") do
            comments[root_comment_key].collect do |c|
            
              display_comment(c, is_new)
            
            end.join.html_safe +
            content_tag(:div, (@root_comment && @root_comment.id == root_comment_key) ? (render :partial => 'comments/form_reply_comment') : "", :class => "wrap_form_new_reply")
          end +
          content_tag(:div,"", :class => "horizontal_rule")
          # )
        end.join
        )
    else
      # raw(
      #   content_tag(:div, "<h1 id='comments_title'>Listing comments</h1>Vous souhaitez commenter cet article, n'hésitez pas => " + (link_to 'Commenter', "#new_comment"))
      # )
    end
  end
  
  def display_comment(comment, is_new = false)
      
      user = comment.getCommentAuthor
      content_tag(:article, :class => (comment.is_root_comment? ? (is_new ? "root_comment new" : "root_comment") : (is_new ? "comment_reply new reply_for_#{comment.parent_id}" : "comment_reply reply_for_#{comment.parent_id}")), :id => "comment_#{comment.id}" ) do
          content_tag(:div, :class => "comment_content") do
            content_tag(:header) do
              content_tag(:div, comment.title.html_safe, :class => "title") + 
                render('moderation_settings/comment_moderation_links', :comment => comment) +
                (link_to('Supprimer', destroy_comment_path(comment), :class => "delete_comment_link", :confirm => 'Are you sure?', :method => :delete, :remote => true) if can? :destroy, comment) +
                (link_to('Éditer', edit_comment_path(commentable_class, commentable, comment), :class => "edit_comment_link fancybox.ajax") if can? :edit, comment)
            end +
            content_tag(:div, simple_format(h comment.body), :class => "comment_body")
          end +
          content_tag(:div, "", :class => "arrow_comment") +
          content_tag(:div, comment_author_link(comment, user) + ", le " + comment.created_at.strftime("%e") + " " + getMonthFromNumber(comment.created_at.strftime("%m")) + " " + comment.created_at.strftime("%Y à %H:%M"), :class => "author_comment_name") +
          content_tag(:div, image_tag(avatar_url(user, 60), :class => "avatar"), :class => "author_comment_image") +
          
          (link_to("Répondre", show_comment_reply_path(commentable_class, commentable, comment.id), :remote => true, :class => "show_reply_fields awesome orange") if comment.is_root_comment?) +
          (content_tag(:p, "", :class => "reply_fields", :id => "reply_comment_#{comment.id}") if comment.is_root_comment?)
      end
  end
  
  def comment_author_link(comment, user)
    # when guest, return guest_website
    if user[:id] == -1
      link_to user[:name], (comment.guest_website || "http://www.changeons.org"), :class => "tooltipped", :title => "Voir le site de cette invité \"#{truncate(comment.guest_website, :length => 40)}\""
    # when user registered, return website
    elsif user[:id] == -2
      user.name
    elsif user.display_name
      link_to user.display_name, show_user_profile_path(user), :class => "tooltipped", :title => "Voir le profil de \"#{user.display_name}\""
    end
  end
  
  def commentable
    @tip || @post || @event || @product_test
  end
  
  def commentable_class
    (@tip || @post || @event || @product_test).class.to_s.underscore.downcase
  end

end
# TRY TO WRAP THE CHILDREN INTO A ROOT DIV
