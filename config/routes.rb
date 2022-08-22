Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get "/users/sign_in" => "devise/sessions#new"
  end

  get '/home', to: 'home#index'
  root "home#index"

  resources :users do
    get 'user_search', :on => :collection
  end
  resources :bugs

  resources :projects do
    resources :bugs
    get 'project_search', :on => :collection
  end

  post '/bugs/:id', to: 'bugs#assign_to', as: :assign_to
  post '/users/:id', to: 'users#assign_project', as: :assign_project
  # get '/projects/project_search/' => 'projects#project_search'
end
