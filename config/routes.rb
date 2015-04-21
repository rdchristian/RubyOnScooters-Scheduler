Rails.application.routes.draw do


  resources :users do
    resources :events
  end
  resources :events, :only => [:index]

  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/events')

  get    'sessions/new'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end