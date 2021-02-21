class User < ApplicationRecord
  class Entity < Base
    expose :email
    expose :time_zone
    expose :group_id
    expose :token
  end

  has_secure_password
  has_secure_token

  validates :email, presence: true
  validates :time_zone, presence: true, numericality: true

  def authenticate(password)
    return unless super
    regenerate_token
  end

  private

  def token?
    true
  end
end