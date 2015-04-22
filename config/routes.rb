Rails.application.routes.draw do


  resources :users do
    resource :events
  end

  resources :events

  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/events')

  get    'sessions/new'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'admin'   => 'master_page#new'
  post   'admin'   => 'master_page#create'
  

end