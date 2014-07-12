class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    # guest      cannot :index, Myad
    can :read, Typead
    can :read, Myad do |ad|
      ad.published? || ad.user == user
    end

    cannot :index, Myad

    can :published, Myad

    if user.user?
      can :read, User
      can :read,   Myad
      can :create, Myad
      can :update, Myad do |ad|
        ad.drafting? && ad.user == user
      end

      can :destroy, Myad do |ad|
        ad.user == user
      end

      cannot :destroy, Myad do |ad|
        ad.banned? || ad.rejected?
      end

      can :event, Myad do |ad|
        !(ad.state_events & Myad.user_events).empty?
      end
      can :update_all_state, Myad
    elsif user.admin?

      can :manage, User
      can :destroy, :all
      can :manage, Typead
      cannot [:create, :update], Myad

      can :read, Myad do |ad|
        ad.freshing? || ad.approved? || ad.banned? ||  ad.rejected?
      end
      can :event, Myad do |ad|
        !(ad.state_events & Myad.admin_events).empty?
      end
      can :update_all_state, Myad
    end
  end
end
