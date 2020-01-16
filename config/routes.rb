Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [] do
        collection do
          get 'list_of_requests'
        end
      end
      resources :videos, only: [] do
        collection do
          post 'upload_video'
        end
      end
    end
  end
end
