module CommentsHelper
  
  # This is to adapt as the comments maybe will be displayed another way !!
  def display_comments(comments, is_new = false)
    sorted_keys = comments.keys.sort.reverse
    
    if comments.any? && sorted_keys.any?
      raw(
      # ("<h1 id='comments_title'>Listing comments</h1>" if title) +
      # Display the content of table
        sorted_keys.collect do |root_comment_key|
          comments[root_comment_key].collect do |c|
            
            display_comment(c, is_new)
            
          end
        end.join
        )
    else
      # raw(
      #   content_tag(:div, "<h1 id='comments_title'>Listing comments</h1>Vous souhaitez commenter cet article, n'hésitez pas => " + (link_to 'Commenter', "#new_comment"))
      # )
    end
  end
  
  def display_comment(comment, is_new = false)
      content_tag(:div, :class => (comment.is_root_comment? ? (is_new ? "root_comment new" : "root_comment") : (is_new ? "comment_reply new reply_for_#{comment.parent_id}" : "comment_reply reply_for_#{comment.parent_id}")), :id => "comment_#{comment.id}" ) do
        
          content_tag(:div, comment.title) + 
          content_tag(:div, comment.body) +
          content_tag(:div, link_to('Show', post_comment_path(@post, comment))) +
          (content_tag(:div, link_to('Edit', edit_post_comment_path(@post, comment))) if can? :edit, comment ) +
          (content_tag(:div, link_to('Destroy', post_comment_path(@post, comment), :confirm => 'Are you sure?', :method => :delete, :remote => true)) if can? :destroy, comment) +
          content_tag(:div, (link_to('Reply', show_reply_post_comment_path(@post, comment), :remote => true, :class => "show_reply_fields") if comment.is_root_comment?) ) +
          (content_tag(:div, "", :class => "reply_fields", :id => "reply_comment_#{comment.id}") if comment.is_root_comment?)
      end
  end
end
# TRY TO WRAP THE CHILDREN INTO A ROOT DIV