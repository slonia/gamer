class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :visits, Team
      can :weekly_toggle, User
      if user.player? && !user.team
        can :create, Game
      end
    end
  end
end
