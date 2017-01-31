Rails.application.routes.draw do
  authenticated :user do
  #  get '/home', to: 'pages#home', as: :authenticated_root
   root 'pages#home', as: :authenticated_root
  end
  root 'pages#index'
  get 'upload' => 'pages#upload'
  get 'profile/:id' => 'pages#profile', as: 'profile'

  resources :selfies do
    resource :like, module: :selfies
    # member do
    #   get "like", to: "selfies#like", via: :post
    #
    #   delete "unlike", to: "selfies#unlike"
    # end
  end
  devise_scope :user do
    get "/signup" => "devise/registrations#new", as: "new_user_registration"
    end
  devise_for :users, skip: [:sessions]
  as :user do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      match 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session,
            :via => Devise.mappings[:user].sign_out_via
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
