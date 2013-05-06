Subscribeto::Application.routes.draw do
  resources :vendors
  resources :customers
  resources :sessions

  resources :users do
    resources :items do
      get :autocomplete_vendor_name, :on => :collection
    end
    resources :raws
    resources :prepareds do
      get :autocomplete_raw_name, :on => :collection
    end
    #resources :sites
    resources :orders 
    #resources :payment_dues
  end

  #get 'user/:id/invoices', to: 'payment_dues#index', as: 'invoices'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  #get "pages/banking", to: 'pages#banking', as: 'banking'
  get "dashboard", to: 'pages#dashboard', as: 'dashboard'
  get "quickstart", to: 'pages#quickstart', as: 'quickstart'
  get "pages/home"
  #post "users/add_bank_account"

  root :to => "pages#home"
end
