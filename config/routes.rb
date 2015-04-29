Rails.application.routes.draw do



  get 'password_resets/new'

  get 'password_resets/edit'

  get 'search/index'

  resources :users do
    resources :events
  end
  resources :events#, :only => [:index]

  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/events')

  resources :searches

  resources :password_resets,     only: [:new, :create, :edit, :update]

  get    'sessions/new'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'admin'   => 'master_page#new'
  post   'admin'   => 'master_page#create'
  get    '/users/password/:id' => 'users#edit_password'
  patch  '/users/password/:id' => 'users#update_password', as: 'update_password'
  get    '/users/activate/:id' => 'users#activate', as: 'activate_user'
  get    '/events/approve/:id' => 'events#approve', as: 'approve_event'
  get    '/events/checkin/:id' => 'events#check_in', as: 'check_in'
  post   '/post/change_schedule_variable' => 'master_page#change_schedule_variable'
  get    '/events/alert' => 'events#check_in_alert', as: 'check_in_alert'

end