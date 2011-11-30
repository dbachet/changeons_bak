module CommentsHelper
  
  # This is to adapt as the comments maybe will be displayed another way !!
  def display_comments(comments, is_new = false)
    sorted_keys = comments.keys.sort
    
    if comments.any? && sorted_keys.any?
      raw(
      # Display the content of table
        sorted_keys.collect do |root_comment_key|
          comments[root_comment_key].collect do |c|
            
            display_comment(c, is_new)
            
          end
        end.join
        )
    end
  end
  
  def display_comment(comment, is_new = false)
      content_tag(:div, :class => (comment.is_root_comment? ? (is_new ? "root_comment new" : "root_comment") : (is_new ? "comment_reply new reply_for_#{comment.parent_id}" : "comment_reply reply_for_#{comment.parent_id}")), :id => "comment_#{comment.id}" ) do
        
          content_tag(:div, comment.title) + 
          content_tag(:div, comment.body) +
          content_tag(:div, link_to('Show', post_comment_path(@post, comment))) +
          content_tag(:div, link_to('Edit', edit_post_comment_path(@post, comment))) +
          content_tag(:div, link_to('Destroy', post_comment_path(@post, comment), :confirm => 'Are you sure?', :method => :delete, :remote => true)) +
          content_tag(:div, (link_to('Reply', show_reply_post_comment_path(@post, comment), :remote => true, :class => "show_reply_fields") if comment.is_root_comment?) ) +
          (content_tag(:div, "", :class => "reply_fields", :id => "reply_comment_#{comment.id}") if comment.is_root_comment?)
      end
  end
end