Rottenpotatoes::Application.routes.draw do
  resources :users do
  end

  match '/myProfile', to: 'users#myProfile', as: 'myProfile', via: :get

  get 'login', to: 'sessions#new', as: 'sign_up'
  post 'login', to: 'sessions#create', as: 'log_in'
  get 'welcome', to: 'sessions#welcome', as: "login_signup"
  get 'authorized', to: 'sessions#page_requires_login'
  get 'logout', to: 'sessions#logout', as: 'logout'

  resources :events do
    resources :comments
  end 
  
  # map '/' to be a redirect to '/events'
  root :to => redirect('/welcome')

  match '/search_result', to: 'events#index', as: 'search_result', via: :get
  match '/join', to: 'events#join', as: 'join', via: :get
  match '/events/:id/promote', to: 'events#promote', as: 'promote', via: :get
  match '/events/:id/ratePeople', to: 'events#ratePeople', as: 'rate', via: :get
  match '/events/:id/rateUser', to: 'users#rateUser', as: 'rate_user', via: :put

  match '/events/:event_id/comments/:id/react/:action_id', to: 'comments#react', as: 'react', via: :put

  get '/auth/:provider/callback' => 'sessions#omniauth', as: 'oauth'
end
