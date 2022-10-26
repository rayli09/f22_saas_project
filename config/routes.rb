Rottenpotatoes::Application.routes.draw do
  resources :events
  # map '/' to be a redirect to '/events'
  root :to => redirect('/events')
end
