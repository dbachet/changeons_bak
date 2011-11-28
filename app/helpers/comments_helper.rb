module CommentsHelper
  
  # This is to adapt as the comments maybe will be displayed another way !!
  def display_comments(comments)
    sorted_keys = comments.keys.sort
    
    puts "sorted_keys => #{sorted_keys.inspect}"
    
    content_tag :div, :class => "display_comments" do
      if comments.any? && sorted_keys.any?
        
        # Display the content of table
        raw(
          sorted_keys.collect do |root_comment_key|
            puts "first comment => #{comments[root_comment_key].inspect}"
            comments[root_comment_key].collect do |comment|
              content_tag(:div, :class => (comment.id == root_comment_key ? "root_comment" : "comment_reply"), :id => ("comment_#{comment.id}" if comment.id == root_comment_key) ) do
                  
                  content_tag(:div, comment.title) + 
                  content_tag(:div, comment.body) +
                  content_tag(:div, link_to('Show', post_comment_path(@post, comment))) +
                  content_tag(:div, link_to('Edit', edit_post_comment_path(@post, comment))) +
                  content_tag(:div, link_to('Destroy', post_comment_path(@post, comment), :confirm => 'Are you sure?', :method => :delete)) +
                  content_tag(:div, (link_to('Reply', show_reply_post_comment_path(@post, comment), :remote => true, :class => "show_reply_fields") if comment.parent_id.nil?) ) +
                  (content_tag(:div, (render("comments/form_reply_comment#{(@reply.user_id == -1 ? "_with_guest_fields" : "")}") if (@comment ? @comment.id : -1) == root_comment_key), :class => "reply_fields", :id => "reply_comment_#{root_comment_key}") if comment.id == root_comment_key)
              end
            end
          
          end.join
        )
      end
    end
  end
end