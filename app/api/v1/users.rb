module API
  module V1
    class Users < Grape::API
      resources :users do
        get do
          authorize! :index, ::User

          present ::User.all
        end

        desc 'Authenticate the user'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post do
          user = ::User.find_by(email: params[:email])
          raise API::Exceptions::AuthenticationError unless user&.authenticate(params[:password])
          present user, current_user: user
        end

        desc 'Signup the user'
        params do
          requires :email, type: String
          requires :password, type: String
          requires :time_zone, type: Integer
          optional :group_id, type: Integer
        end
        post :signup do
          user = ::User.create!(
            email: params[:email],
            password: params[:password],
            time_zone: params[:time_zone],
            group_id: params[:group_id]
          )
          present user, current_user: user
        end

        desc 'Logout user'
        post :logout do
          current_user&.logout!

          :ok
        end

        desc 'Delete user'
        delete do
          authorize! :destroy, current_user

          current_user.destroy!

          :ok
        end
      end
    end
  end
end