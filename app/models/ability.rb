class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    user ||= User.new# (:role => "guest") # guest user (not logged in)
    
    if user.role? :admin
      can :manage, :all
      cannot [:show_guest_fields, :show_guest_fields_for_reply, :comment_as_guest, :create_comment_as_guest, :create_reply_as_guest], Comment
    elsif user.role? :moderator
      can :manage, :all
      cannot [:show_guest_fields, :show_guest_fields_for_reply, :comment_as_guest, :create_comment_as_guest, :create_reply_as_guest], Comment
    elsif user.role? :user
      can [:index, :show, :show_more_posts, :vote_up, :vote_down], Post
      can [:create_reply, :create, :show_reply, :show_more_comments], Comment # :edit, :update, :destroy if user.id is the same
      can [:edit, :update, :destroy], Comment , :user_id => user.id
      # can [:update, :destroy], Comment
    else
      can [:index, :show, :show_more_posts], Post
      can :manage, Comment
      cannot [:create_reply, :create, :edit, :update, :destroy], Comment
      
    end
  end
end