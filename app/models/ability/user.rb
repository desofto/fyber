module Ability
  class User < Ability::Base
    def permissions
      can :index, ::User
      can :destroy, ::User do |user|
        user == @user
      end

      can :index, ::Group
      can :show, ::Group
    end
  end
end