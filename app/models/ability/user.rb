module Ability
  class User < Ability::Base
    def permissions
      can :index, ::User
      can :show, ::User do |user|
        user == @user
      end
      can :update, ::User do |user|
        user == @user
      end
      can :destroy, ::User do |user|
        user == @user
      end

      can :index, ::Group
      can :show, ::Group

      can :index, ::Message
      can :create, ::Message
    end
  end
end