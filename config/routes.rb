Subscribeto::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :sessions

  resources :users do
    resources :delivery_slots, :only => ["index", "create", "destroy"]
    resources :items do
      get :autocomplete_vendor_name, :on => :collection
    end
    resources :prepareds 
    resources :customers
    resources :orders do
      get :autocomplete_customer_company_name, :on => :collection
      get :autocomplete_item_name, :on => :collection
    end 
    resources :invoices, :controller => "payment_dues"
  end

  post 'mark_delivered', to: 'pages#mark_delivered'
  post 'email_invoice/:payment_due_id', to: 'payment_dues#email', as: 'email_invoice'
  get 'users/:user_id/customers/:customer_id/orders/new', to: 'customers#new_order'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get "dashboard", to: 'pages#dashboard', as: 'dashboard'
  get "quickstart", to: 'pages#quickstart', as: 'quickstart'
  get "pages/home"

  root :to => "pages#home"
end
