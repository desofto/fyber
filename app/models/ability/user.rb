module Ability
  class User < Ability::Base
    def permissions
      can :index, ::User
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