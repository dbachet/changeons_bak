# -*- encoding : utf-8 -*-
module CommentsHelper
  
  # This is to adapt as the comments maybe will be displayed another way !!
  def display_comments(comments, is_new = false)
    puts comments.inspect
    
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
          content_tag(:div,"", :class => "horizontal_rule_main")
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
      
      user = comment.getUserInfo
      
      content_tag(:article, :class => (comment.is_root_comment? ? (is_new ? "root_comment new" : "root_comment") : (is_new ? "comment_reply new reply_for_#{comment.parent_id}" : "comment_reply reply_for_#{comment.parent_id}")), :id => "comment_#{comment.id}" ) do
          content_tag(:div, :class => "comment_content") do
            content_tag(:header) do
              content_tag(:div, comment.title.html_safe, :class => "title") + 
                (link_to('Supprimer', polymorphic_path([(@tip || @post || @event || @product_test || @comment_parent_object), comment]), :class => "delete_comment_link", :confirm => 'Are you sure?', :method => :delete, :remote => true) if can? :destroy, comment) +
                (link_to('Éditer', edit_polymorphic_path([(@tip || @post || @event || @product_test || @comment_parent_object), comment]), :class => "edit_comment_link fancybox.ajax") if can? :edit, comment)
            end +
            content_tag(:div, simple_format(h comment.body), :class => "comment_body")
          end +
          content_tag(:div, "", :class => "arrow_comment") +
          content_tag(:div, "#{user[:name] || user.display_name }, le #{comment.created_at.strftime("%e")} #{getMonthFromNumber(comment.created_at.strftime("%m"))} #{comment.created_at.strftime("%Y à %H:%M")}", :class => "author_comment_name") +
          content_tag(:div, image_tag(avatar_url(user, 60), :class => "avatar"), :class => "author_comment_image") +
          
          (show_reply_link((@tip || @post || @event || @product_test || @comment_parent_object), comment)) +
          (content_tag(:p, "", :class => "reply_fields", :id => "reply_comment_#{comment.id}") if comment.is_root_comment?)
      end
  end
  
  def show_reply_link(model_variable, comment)
    model_name = model_variable.class.to_s.underscore
    link_to('Répondre', eval("show_reply_#{model_name}_comment_path(#{model_variable.id}, #{comment.id})"), :remote => true, :class => "show_reply_fields awesome orange") if comment.is_root_comment?
  end
  
  def create_reply_link
    model_name = @comment_parent_object.class.to_s.underscore
    eval("create_reply_#{model_name}_comment_path(#{@comment_parent_object.id}, #{@root_comment.id})")
    # create_reply_post_comment_path(@post, @root_comment, :anchor => "reply_comment_#{@root_comment.id}")
  end
  
  def create_comment_as_guest_link
    model_name = @comment_parent_object.class.to_s.underscore
    eval("#{model_name}_create_comment_as_guest_path(#{@comment_parent_object.id})")
    # create_comment_as_guest_path(@post)
  end
  
  def create_reply_as_guest_link
    model_name = @comment_parent_object.class.to_s.underscore
    eval("#{model_name}_create_reply_as_guest_path(#{@comment_parent_object.id}, #{@root_comment.id})")
    # create_reply_as_guest_path(@post, @root_comment)
  end
  
  def show_guest_fields_link(model_variable)
    model_name = model_variable.class.to_s.underscore
    # eval("#{model_name}_show_guest_fields_path(#{@commentable.id})")
    link_to "Invité", eval("#{model_name}_show_guest_fields_path(#{model_variable.id})"), :remote => true
    # show_guest_fields_path(@tip || @post || @event || @product_test)
  end
  
  def show_guest_fields_for_reply_link(model_variable)
    model_name = model_variable.class.to_s.underscore
    link_to "Invité", eval("#{model_name}_show_guest_fields_for_reply_path(#{model_variable.id})"), :remote => true, :id => "write_reply_as_guest_link"
  end
end
# TRY TO WRAP THE CHILDREN INTO A ROOT DIV
