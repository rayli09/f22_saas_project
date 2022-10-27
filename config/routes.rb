Rottenpotatoes::Application.routes.draw do
  resources :events
  # map '/' to be a redirect to '/events'
  root :to => redirect('/events')

  match '/myEvents', to: 'events#myEvents', as: 'myEvents', via: :get 
end
