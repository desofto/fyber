# frozen_string_literal: true

module API
  module V1
    class Root < Grape::API
      include API::Auth
      include API::Exceptions

      helpers do
        def declared_params
          declared(params, include_missing: false)
        end

        def current_user
          @current_user ||=
            begin
              token = params[:token]
              token.presence && User.find_by(token: token)
            end
        end

        def authorize!(*args)
          ::Ability::Factory.build_ability_for(current_user).authorize!(*args)
        end
      end

      before do
        # it is unnecessary to check it against CSRF attack because we pass token as a parameter, not in headers
        # raise CanCan::AccessDenied unless verified_request?
      end

      before do
        if current_user.present?
          Time.zone = current_user&.time_zone
        else
          Time.zone = Rails.configuration.time_zone
        end
      end

      after do
        Time.zone = Rails.configuration.time_zone
      end

      version 'v1', using: :path
      format :json

      mount API::V1::Ping
      mount API::V1::Users
      mount API::V1::Groups
      mount API::V1::Messages
    end
  end
end