Rottenpotatoes::Application.routes.draw do
  resources :events
  # map '/' to be a redirect to '/events'
  root :to => redirect('/events')

  match '/myEvents', to: 'events#myEvents', as: 'myEvents', via: :get 
  match '/search', to: 'events#search', as: 'search', via: :get
  match '/search_result', to: 'events#search_result', as: 'search_result', via: :get
end
