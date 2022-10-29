Rottenpotatoes::Application.routes.draw do
  resources :events
  # map '/' to be a redirect to '/events'
  root :to => redirect('/events')
  
  match '/myEvents', to: 'events#myEvents', as: 'myEvents', via: :get 
  match '/search', to: 'events#search', as: 'search', via: :get   #TODO? why is this GET?
  match '/search_result', to: 'events#index', as: 'search_result', via: :get
  match '/join', to: 'events#join', as: 'join', via: :get

end
