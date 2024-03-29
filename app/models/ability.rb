# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    if user.has_role? :Admin
      can :manage, :all
      # can :delete_all, :all

    elsif user.has_role? :Moderator
      can :manage, Student, school_id: user.school_id
      can :manage, Log, user_id: user.id
      
    elsif user.has_role? :Parent
      can :manage, Parent, user_id: user.id
      can :read, StudentReport 
      # can :manage, Log, user_id: user.id 



    end 
    
    # return unless user.has_role? :Moderator  # additional permissions for administrators
    # can :manage, Log   
    
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
