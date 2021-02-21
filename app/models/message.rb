class Message < ApplicationRecord
  class Entity < Base
    expose :text

    expose :sender_id
    expose :group_id
    expose :user_id
  end
end