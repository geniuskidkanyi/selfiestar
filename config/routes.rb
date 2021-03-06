Rails.application.routes.draw do
  get 'admin/dashboard'

  devise_scope :user do
 get "/signup" => "devise/registrations#new", as: "new_user_registration"
    end
 devise_for :users, skip: [:sessions] #,:controllers => {:registrations => "registrations"}
 as :user do

     get 'login' => 'devise/sessions#new', :as => :new_user_session
     post 'login' => 'devise/sessions#create', :as => :user_session
     match 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session,
           :via => Devise.mappings[:user].sign_out_via
 end
  get 'password_resets/new'

  get 'password_resets/edit'

  authenticated :user do
  #  get '/home', to: 'pages#home', as: :authenticated_root
   root 'pages#home', as: :authenticated_root
  end
  root 'pages#index'
  get 'upload' => 'pages#upload'
  get 'subscribe' => 'pages#subscribe'
  resources :subscribes, only: [:create, :new]
  get 'browser'=> 'pages#browser'
  get 'about' => 'pages#about'
  get 'winners' => 'pages#winner'
  get 'token' => 'password_resets#token'
  post 'find_token' => 'password_resets#find_token'
  get ':username' => 'pages#profile', as: :user
  get "/fetch_selfie/:id" => 'selfies#show', as: 'fetch_selfy'
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :selfies do
    resource :like, module: :selfies
    resources :comments, module: :selfies
    # member do
    #   get "like", to: "selfies#like", via: :post
    #
    #   delete "unlike", to: "selfies#unlike"
    # end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
