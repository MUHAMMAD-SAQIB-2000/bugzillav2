class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new
    if user != nil
      if user.user_type == 'QA'
        can [:read], Project
        can [:manage], Bug
        can [:read], User
        can :project_search, Project
        can :user_search, User
      elsif user.user_type == 'Manager'
        can [:manage, :delete, :destroy], Project
        can [:manage], User
        can [:manage], Bug
        can :user_search, User

      elsif user.user_type == 'Developer'
        can :read, User
        can [:read], Project
        can [:read, :change_status], Bug
      end
    else
      can :read, :users_sign_in
    end
  end
end
