Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [] do
        collection do
          get 'list_of_requests'
        end
      end
      resources :videos, only: [:index, :show] do
          member do
            post 'failed/retry', to: 'videos#retry', as: 'retry'
          end

        collection do
          post 'upload'
        end
      end
    end
  end
end
