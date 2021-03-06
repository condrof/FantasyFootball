class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
     if user
       if user.admin?
         can :manage, :all
       else 
         if League.first && !League.first.lock 
          can :create, League
          can :create, Team 
         end
         
         can [:update, :destroy], Team do |team|
           team.try(:user_id) == user.id && League.first && !League.first.lock 
         end
         can [:read], Team do |team|
           team.try(:user_id) == user.id && League.first && League.first.lock
         end
         can [:update, :destroy], User do |tryuser|
           tryuser == user
         end
         can [:create, :destroy], TeamPlayer do |teamplayer|
           teamplayer.team.user == user
         end     
         can :create, Post do |post|
            !user.lock         
         end
         can [:update, :destroy], Post do |post|
           post.user_id == user.id && !user.lock
         end
         can [:create], Topic do |topic|
           !user.lock
         end
       end
         
         if user.moderator?
           can [:create, :update, :destroy], Post
           can [:create, :update, :destroy], Topic
         end
         
       end
       can :read, [Player, User, Category, Forum, Post, Topic, League]
     end
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
end
