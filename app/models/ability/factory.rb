module Ability
  class Factory
    def self.build_ability_for(user)
      if user
        Ability::User.new(user)
      else
        Ability::Anonymous.new(nil)
      end
    end
  end
end