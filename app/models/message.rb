class Message < ApplicationRecord
  class Entity < Base
    expose :text

    expose :sender_id
    expose :group_id
    expose :user_id
  end

  validates :text, presence: true
  validates :sender_id, presence: true

  validates :group_id, presence: true, if: -> { user_id.blank? }
  validates :user_id, presence: true, if: -> { group_id.blank? }

  belongs_to :user, optional: true
  belongs_to :sender, class_name: '::User'
  belongs_to :group, optional: true
end