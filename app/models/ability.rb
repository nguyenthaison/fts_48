class Ability
  include CanCan::Ability

  def initialize user
    alias_action :create, :show, :update, :new, :index, to: :crud
    return if user.nil?
    if user.admin?
      can :manage, :all
    else
      can [:update, :show], User, id: user.id
      can [:index], Subject
      can [:new, :create, :index, :show], Question
      can [:edit, :update, :destroy], Question, user_id: user.id
      can [:crud], Exam, user_id: user.id
    end
  end
end
