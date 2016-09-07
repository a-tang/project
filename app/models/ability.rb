class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin?

    alias_action :create, :read, :update, :to => :cru

    can :cru, Contest do |comp|
      comp.user == user && user.persisted?
    end

    can :read, :all
  end
  
end
