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
          optional :group_name, type: String
        end
        post :signup do
          user = ::User.create!(
            email: params[:email],
            password: params[:password],
            time_zone: params[:time_zone],
            group_id: params[:group_id]
          )

          if params[:group_name]
            group = ::Group.find_by(name: params[:group_name]) || ::Group.create!(name: params[:group_name])
            user.update!(group: group)
          end

          present user, current_user: user
        end

        desc 'Current user detaile'
        get :me do
          authorize! :show, current_user

          present current_user
        end

        desc 'Update current user detaile'
        params do
          optional :email, type: String
          optional :password, type: String
          optional :time_zone, type: Integer
          optional :group_id, type: Integer
        end
        post :me do
          authorize! :update, current_user

          current_user.update(declared_params)

          present current_user
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