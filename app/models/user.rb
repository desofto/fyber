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

  belongs_to :group, optional: true

  has_many :messages

  after_destroy :test_and_destroy_group

  def authenticate(password)
    return unless super
    regenerate_token
  end

  private

  def test_and_destroy_group
    group&.try_destroy
  end

  def token?
    true
  end
end