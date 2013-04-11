Subscribeto::Application.routes.draw do
  resources :sessions
  resources :users

  match "/signup" => "users#new"

  get "pages/banking"
  get "pages/home"

  root :to => "pages#home"
end
