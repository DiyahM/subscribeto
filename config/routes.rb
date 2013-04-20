Subscribeto::Application.routes.draw do


  resources :sessions
  resources :users do
    resources :plans
    resources :sites
  end

  match "/signup" => "users#new"

  get "pages/banking"
  get "pages/home"
  post "users/add_bank_account"

  root :to => "pages#home"
end
