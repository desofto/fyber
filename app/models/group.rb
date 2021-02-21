class Group < ApplicationRecord
  class Entity < Base
    expose :name
  end

  validates :name, presence: true

  has_many :users

  has_many :messages

  def try_destroy
    return if users.any?
    destroy!
  end
end