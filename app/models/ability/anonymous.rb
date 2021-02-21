module Ability
  class Anonymous < Ability::Base
    def permissions
      can :index, ::Group
    end
  end
end