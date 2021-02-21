module API
  module V1
    class Messages < Grape::API
      resources :messages do
        desc 'Get all messages'
        get do
          authorize! :index, ::Message

          messages = ::Message.where('messages.user_id = :user_id OR group_id = :group_id', user_id: current_user.id, group_id: current_user.group_id)

          (present messages).to_json
        end

        desc 'Post a message'
        params do
          requires :text, type: String
          optional :user_id, type: Integer
          optional :group_id, type: Integer
        end
        post do
          authorize! :create, ::Message

          message = ::Message.create!(
            text: params[:text],
            user_id: params[:user_id],
            group_id: params[:group_id],
            sender_id: current_user.id
          )

          present :ok
        end
      end
    end
  end
end