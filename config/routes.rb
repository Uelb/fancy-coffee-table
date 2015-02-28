Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [], shallow: true do 
    resources :users, only: :index
    resources :rooms, only: [:index, :create, :destroy, :update] do 
      resources :messages, only: [:index, :create, :destroy, :update]
    end
    resources :evaluations, only: [:index, :create, :update] do 
      collection do 
        get :average
      end
    end
  end
end
