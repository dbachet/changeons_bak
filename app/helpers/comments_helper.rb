module CommentsHelper
  
  # sort as {1=>[#<Comment>, #<Comment>], 8=>#<Comment>}
  def sort_comments(comments)
    hash = {}

    comments.each do |comment|
      if comment.parent_id.nil?
        hash[comment.id] = [comment]
      else
        hash[comment.parent_id] << comment
      end
    end
    
    hash
  end
  
  # This is to adapt as the comments maybe will be displayed another way !!
  def display_comments(comments)
    sorted_threads = sort_comments(comments)
    sorted_keys = sorted_threads.keys.sort
    
    content_tag :table, :class => "display_comments" do
      if comments.any? && sorted_keys.any?
        # Display headers of table
        raw(
          content_tag(:tr) do
            content_tag(:th, "Title") +
            content_tag(:th, "Comment") +
            content_tag(:th) +
            content_tag(:th) +
            content_tag(:th)
          end) +
        
        # Display the content of table
        raw(
          sorted_keys.collect do |root_comment_key|

            sorted_threads[root_comment_key].collect do |comment|
              content_tag(:tr, :class => (comment.id == root_comment_key ? "root_comment" : "comment_reply")) do
                
                  content_tag(:td, comment.title) +
                  content_tag(:td, comment.body) +
                  content_tag(:td, link_to('Show', post_comment_path(@post, comment))) +
                  content_tag(:td, link_to('Edit', edit_post_comment_path(@post, comment))) +
                  content_tag(:td, link_to('Destroy', post_comment_path(@post, comment), :confirm => 'Are you sure?', :method => :delete)) +
                  content_tag(:td, (link_to('Reply', reply_post_comment_path(@post, comment)) if comment.parent_id.nil?) )
                
              end
            end
          
          end.join
        )
      end
    end
  end
end