class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    if user.role.try(:name) == "admin"
      can :manage, :all
    elsif user.role.try(:name) == "user"
      cannot :manage, :all  
    end
   end
end