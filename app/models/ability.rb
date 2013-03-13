class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Execution, :user_id => user.id
  end
end
