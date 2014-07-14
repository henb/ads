class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action *Myad.state_machine.events.map(&:name), to: :events
    #alias_action *Myad.state_machine.events.map(&:name), to: :update_all_state

    can :read, Typead
    can :read, Myad, state: 4 # state_name: :published
    can :published, Myad
    can :fresh, Myad
    if user.user?
      can :read, User
      can :read, Myad, user_id: user.id
      can :create, Myad
      can [:edit, :update], Myad, state_name: :drafting
      can :destroy, Myad, user_id: user.id
      cannot :destroy, Myad, state_name: [:banned, :rejected]
      can :events, Myad do |ad|
        !(ad.state_events & Myad.user_events).empty?
      end
      can :update_all_state, Myad
    elsif user.admin?

      can :manage, [User, Typead]
      can :destroy, :all
      cannot [:create, :update], Myad
      can :read, Myad, state: Myad.admin_state
      can :events, Myad do |ad|
        !(ad.state_events & Myad.admin_events).empty?
      end
      can :update_all_state, Myad
    end
  end
end
