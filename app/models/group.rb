class Group < ApplicationRecord
  class Entity < Base
    expose :name
  end

  validates :name, presence: true
end