Rails.application.routes.draw do



  get 'password_resets/new'

  get 'password_resets/edit'

  get 'search/index'

  resources :users do
    resources :events
  end
  resources :events, :only => [:index]

  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/events')

  resources :password_resets,     only: [:new, :create, :edit, :update]

  get    'search' => 'search#show'
  %w( events resources facilities ).each do |r|
    get "search/#{r}/" => "search#search_#{r}"
  end

  get    'sessions/new'
  get    'calendar'  => 'calendar#show'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'admin'   => 'master_page#new'
  post   'admin'   => 'master_page#create'
  get    '/users/password/:id' => 'users#edit_password'
  patch  '/users/password/:id' => 'users#update_password', as: 'update_password'
  get    '/users/activate/:id' => 'users#activate', as: 'activate_user'
  post   '/users/deny/:id' => 'users#deny', as: 'deny_user'
  get    '/events/approve/:id' => 'events#approve', as: 'approve_event'
  post   '/events/deny/:id' => 'events#deny', as: 'deny_event'
  get    '/events/checkin/:id' => 'events#check_in', as: 'check_in'
  post   '/post/change_schedule_variable' => 'master_page#change_schedule_variable'
  get    '/events/alert/:id' => 'events#alert', as: 'alert'

end