Subscribeto::Application.routes.draw do
  resources :customers
  resources :sessions

  resources :users do
    resources :plans
    resources :sites
    resources :orders
  end

  match "/signup" => "users#new"

  get "pages/banking"
  get "pages/home"
  post "users/add_bank_account"

  #root :to => "public#index"
end
