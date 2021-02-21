class User < ApplicationRecord
  class Entity < Base
    expose :email
    expose :time_zone
    expose :group_id
    expose :token
  end

  has_secure_password
end