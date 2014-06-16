class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)

      # guest
      can :read, Typead
      can :read, Myad do |ad|
        ad.published? || ad.user == user
      end

      if user.role == "user"

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
         
      elsif user.role == "admin"
        can :destroy, :all
        can :manage, Typead
        cannot [:create,:update], Myad

        can :read, Myad do |ad|
          ad.freshing? || ad.approved? || ad.banned? ||  ad.rejected?
        end
        can :event, Myad do |ad|
          !(ad.state_events & Myad.admin_events).empty?
        end
      end

  end


end
