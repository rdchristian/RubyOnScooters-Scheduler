Rails.application.routes.draw do




  get 'search/index'

  resources :users do
    resources :events
  end
  resources :events, :only => [:index]

  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/search')

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

  #Activation Routes
  get    '/users/activate/:id' => 'users#activate', as: 'activate_user'
  get    '/users/activate_email/:id' => 'users#activate_email', as: 'activate_user_email'
  get    '/users/activate_text/:id' => 'users#activate_text', as: 'activate_user_text'
  get    '/users/activate_text_and_email/:id' => 'users#activate_text_and_email', as: 'activate_user_text_and_email'
  post   '/users/deny/:id' => 'users#deny', as: 'deny_user'

#Approving Event Routes
  get    '/events/approve/:id' => 'events#approve', as: 'approve_event'
  get    '/events/approve_email/:id' => 'events#approve_email', as: 'approve_event_email'
  get    '/events/approve_text/:id' => 'events#approve_text', as: 'approve_event_text'
  get    '/events/approve_text_and_email/:id' => 'events#approve_text_and_email', as: 'approve_event_text_and_email'


  post   '/events/deny/:id' => 'events#deny', as: 'deny_event'


  get    '/events/checkin/:id' => 'events#check_in', as: 'check_in'
  post   '/post/change_schedule_variable' => 'master_page#change_schedule_variable'
  get    '/events/alert/:id' => 'events#alert', as: 'alert'

#Text Routes
  get    '/notifications/check_in_reminder/:id' => 'notifications#check_in_reminder', as: 'check_in_text'
  get    '/notifications/account_activated/:id' => 'notifications#account_activated', as: 'account_activated_text'
  get    '/notifications/event_approved/:id' => 'notifications#event_approved', as: 'event_approved_text'
  get    '/notifications/event_denied/:id' => 'notifications#event_denied', as: 'event_denied_text'
  get    '/notifications/account_denied/:id' => 'notifications#account_denied', as: 'account_denied_text'

  post   '/users/password/reset' => 'users#forgot_password', as: 'reset_password'

end