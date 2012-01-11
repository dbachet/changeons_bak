module CommentsHelper
  
  # This is to adapt as the comments maybe will be displayed another way !!
  def display_comments(comments, is_new = false)
    
    
    if comments.any?
      sorted_keys = comments.keys.sort.reverse
      raw(
      # ("<h1 id='comments_title'>Listing comments</h1>" if title) +
      # Display the content of table
        sorted_keys.collect do |root_comment_key|
          # raw(
          content_tag(:div, :class => "root_comment_area #{root_comment_key}") do
            comments[root_comment_key].collect do |c|
            
              display_comment(c, is_new)
            
            end.join.html_safe
          end
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
      content_tag(:article, :class => (comment.is_root_comment? ? (is_new ? "root_comment new" : "root_comment") : (is_new ? "comment_reply new reply_for_#{comment.parent_id}" : "comment_reply reply_for_#{comment.parent_id}")), :id => "comment_#{comment.id}" ) do
          content_tag(:div, :class => "comment_content") do
            content_tag(:header, comment.title) +
            content_tag(:div, comment.body, :class => "comment_body")
          end +
          content_tag(:div, "", :class => "arrow_comment") +
          content_tag(:div, "#{comment.user.email}, le #{comment.created_at.strftime("%e")} #{getMonthFromNumber(comment.created_at.strftime("%m"))} #{comment.created_at.strftime("%Y")}", :class => "author_comment_name") +
          content_tag(:div, content_tag(:img, "", :src => "/images/default_user_image.jpg", :class => "avatar"), :class => "author_comment_image") +
          (content_tag(:p, link_to('Edit', edit_post_comment_path(@post, comment), :class => "edit_comment_link fancybox.ajax")) if can? :edit, comment ) +
          (content_tag(:p, link_to('Destroy', post_comment_path(@post, comment), :confirm => 'Are you sure?', :method => :delete, :remote => true)) if can? :destroy, comment) +
          content_tag(:p, (link_to('Reply', show_reply_post_comment_path(@post, comment), :remote => true, :class => "show_reply_fields") if comment.is_root_comment?) ) +
          (content_tag(:p, "", :class => "reply_fields", :id => "reply_comment_#{comment.id}") if comment.is_root_comment?)
      end
  end
end
# TRY TO WRAP THE CHILDREN INTO A ROOT DIV