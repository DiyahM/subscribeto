Subscribeto::Application.routes.draw do
  resources :users


  get "pages/home"

  root :to => "pages#home"
end
