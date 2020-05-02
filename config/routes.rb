Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }
  scope module: :public do
    root to: 'homes#top'
    resources :customers, only: [:show, :edit, :update]
    get '/customers/withdraw' => 'customers#withdraw'
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete '/cart_items' => 'cart_items#destroy_all'
    resources :orders, only: [:index, :show, :new, :create]
    get '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
