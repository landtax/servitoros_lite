class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, Execution, :user_id => user.id
    can :create, Execution
  end
end
