module API
  module V1
    class Groups < Grape::API
      resources :groups do
        get do
          authorize! :index, ::Group

          present ::Group.all, with: ::Group::ShortEntity
        end

        route_param :id do
          helpers do
            def group
              @group ||= ::Group.find(params[:id])
            end
          end

          get do
            authorize! :show, group

            present group
          end
        end
      end
    end
  end
end