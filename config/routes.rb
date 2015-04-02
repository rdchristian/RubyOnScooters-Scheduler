Rails.application.routes.draw do
  resources :resources

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :facilities
  root :to => redirect('/facilities')
end