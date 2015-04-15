Rails.application.routes.draw do
  get 'sessions/new'

  resources :users do
    resource :events
  end

  resources :events

  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/events')

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end