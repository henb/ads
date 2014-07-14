class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Typead
    can :read, Myad, state_name: :published, user_id: user.id
    cannot :index, Myad
    can :published, Myad

    if user.user?
      can :read, [User, Myad]
      can :create, Myad
      can :update, Myad, state_name: :drafting, user_id: user.id
      can :destroy, Myad, user_id: user.id
      cannot :destroy, Myad do |ad|
        ad.state_name.in? [:banned, :rejected]
      end
      can :event, Myad do |ad|
        !(ad.state_events & Myad.user_events).empty?
      end
      can :update_all_state, Myad
    elsif user.admin?

      can :manage, [User, Typead]
      can :destroy, :all
      cannot [:create, :update], Myad
      can :read, Myad do |ad|
        ad.state_name.in? [:freshing, :approved, :banned, :rejected]
      end
      can :event, Myad do |ad|
        !(ad.state_events & Myad.admin_events).empty?
      end
      can :update_all_state, Myad
    end
  end
end
