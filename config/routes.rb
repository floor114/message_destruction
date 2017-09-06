Rails.application.routes.draw do
  root to: 'home#index'

  resources :messages do
    collection do
      get :search
      post :find
    end
  end
end
