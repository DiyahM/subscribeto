Subscribeto::Application.routes.draw do

  get "password_resets/new"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :password_resets
  resources :sessions
  post '/invoice/:id', to: 'invoices#update'

  resources :bills, as: "weekly_schedules"
  
  resources :users do
    resources :delivery_slots, :only => ["index", "create", "destroy"]
    resources :customers, :except => ["destroy"] 
    get "customers/:id/archive", to: 'customers#archive', as: 'archive_customer'
    resources :invoices
    get "/invoices/pdfs/:id", to: 'invoices#pdf', as: 'invoices_pdf'
    resources :weekly_schedules, :only => ["create", "update"]
    resources :items, :only => ["new", "create", "update", "index", "edit"]
    get "items/:id/archive", to: 'items#archive', as: 'archive_item'
    get "delivery_slots/:id/archive", to: 'delivery_slots#archive', as: 'archive_delivery_slot'
  end
  
  post 'email_invoice/:invoice_id', to: 'invoices#email', as: 'email_invoice'
  post 'invoices/export_iif', to: 'invoices#export_iif'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get "dashboard", to: 'pages#dashboard', as: 'dashboard'
  get "setup", to: 'pages#setup', as: 'setup'
  get "pages/home"

  root :to => "pages#home"
end
