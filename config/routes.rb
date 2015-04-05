Rails.application.routes.draw do
  resources :users do
    resource :events
  end

  resources :events

  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/facilities')
end