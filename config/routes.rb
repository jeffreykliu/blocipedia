Rails.application.routes.draw do

  devise_for :users,  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  resources :charges, only: [:new, :create]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
