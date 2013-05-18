Subscribeto::Application.routes.draw do
  #resources :vendors
  resources :sessions

  resources :users do
    resources :delivery_slots, :only => ["index", "create", "destroy"]
    resources :items do
      get :autocomplete_vendor_name, :on => :collection
    end
    resources :raws
    resources :prepareds 
    resources :customers
    #resources :sites
    resources :orders do
      get :autocomplete_customer_company_name, :on => :collection
      get :autocomplete_item_name, :on => :collection
    end 
    #resources :payment_dues
  end

  post 'mark_delivered', to: 'pages#mark_delivered'
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
