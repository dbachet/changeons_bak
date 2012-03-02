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
      cannot [:edit, :update, :destroy], NewsletterSubscriber
      cannot [:new, :edit, :update, :destroy], :admin_registration
      cannot [:show_guest_fields, :show_guest_fields_for_reply, :comment_as_guest, :create_comment_as_guest, :create_reply_as_guest], Comment
    elsif user.role? :user
      can [:create], NewsletterSubscriber
      can [:index, :show, :show_more_posts, :vote_up, :vote_down], Post
      can [:create_reply, :create, :show_reply, :show_more_comments], Comment
      can [:edit, :update, :destroy], Comment , :user_id => user.id
      can [:home, :tips, :about, :search], :pages
      can :archives, Post
      can :manage, Tip, :user_id => user.id
      can :manage, Event, :user_id => user.id
      can :manage, ProductTest, :user_id => user.id
      can [:show_posts], Tag
      can [:show, :index], Question
      can [:show], Category
    else
      can [:create], NewsletterSubscriber
      can [:index, :show, :show_more_posts], Post
      can :manage, Comment
      cannot [:create_reply, :create, :edit, :update, :destroy], Comment
      can [:home, :tips, :about, :search], :pages
      can :archives, Post
      can [:index, :show], Tip
      can [:index, :show], Event
      can [:index, :show], ProductTest
      can [:show_posts], Tag
      can [:show, :index], Question
      can [:show], Category
    end
  end
end
