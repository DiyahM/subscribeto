Subscribeto::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :sessions
  get "marketplace", to: 'items#index' 
  get '/items/:id', to: 'items#show', as: 'show_item'
  post '/line_items/:id', to: 'line_items#update'
  
  resources :users do
    resources :delivery_slots, :only => ["index", "create", "destroy"]
    resources :order_templates, :only => ["create", "destroy"]
    post "order_templates/create_order/", to: 'order_templates#create_order', as: 'template_create_order'
    get '/items', to: 'items#my_items', as: 'items'
    resources :prepareds 
    resources :customers
    resources :orders do
      get :autocomplete_customer_company_name, :on => :collection
      get :autocomplete_item_name, :on => :collection
    end 
    resources :invoices, :controller => "payment_dues"
    get "/quickbooks/import_qb_customers"
    get "/profile/:id", to: 'profiles#show', as: 'profile'
    get "profile/:id/edit", to: 'profiles#edit', as: 'profile_edit'
    put "/profile/:id", to: 'profiles#update'
  end
  
  post "/customers/import_from_qb"
  post 'mark_delivered', to: 'pages#mark_delivered'
  post 'email_invoice/:payment_due_id', to: 'payment_dues#email', as: 'email_invoice'
  get 'users/:user_id/customers/:customer_id/orders/new', to: 'customers#new_order'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get "dashboard", to: 'pages#dashboard', as: 'dashboard'
  get "quickstart", to: 'pages#quickstart', as: 'quickstart'
  get "pages/home"
  get "quickbooks/authenticate"
  get "quickbooks/oauth_callback"

  root :to => "pages#home"
end
