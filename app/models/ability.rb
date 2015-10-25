class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    alias_action :create, :read, :update, :delete, to: :crud

    # Any visitor
    can :read, :all
    cannot :read, Post, status: CommonStatus::INACTIVE
    cannot :read, Theme, status: CommonStatus::INACTIVE
    can :create, Comment

    if user.regular?
      can :destroy, Comment, user_id: user.id
      can :manage, Post, blogger: { user_id: user.id }
    end

    if user.admin?
      can :manage, :all
    end

    if user.pastor?

    end

    if user.blogger?
      can :manage, Post, blogger: { user_id: user.id }
      can :manage, Theme, blogger: { user_id: user.id }
      can :manage, Blogger, user_id: user.id
    end

    if user.accountant?

    end

    if user.teacher?

    end

    if user.director?

    end
    
  end
end
