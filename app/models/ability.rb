# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(hct)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)

    if hct.admin?
      can :manage, :all
    elsif hct.normal?
      can %i[read update], Hct, id: hct.id
      can :read, Firm, active: true
      can :manage, QueryDefinition, hct_id: hct.id

      can :read, RequestMessage, query_definition: { hct_id: hct.id }
      can %i[read create], RequestMessage, sender_hct_id: hct.id

      can :read, ResponseMessage do |response|
        can? :read, response.request_message
      end
      can :create, ResponseMessage do |response|
        response.request_message.query_definition.id == hct.id
      end

    end

    #   else
    #     can :read, :all
    #   end
    #
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
