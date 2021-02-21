module Ability
  class Factory
    def self.build_ability_for(user)
      Ability::User.new(user)
    end
  end
end