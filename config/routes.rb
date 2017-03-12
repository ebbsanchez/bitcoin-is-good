Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]
  resources :transactions

  scope '/dashboard' do
    get '', to: 'dashboard#home'
    get '/upgrade', to: 'dashboard#upgrade_page'
    get '/upgrade_check', to: 'dashboard#upgrade_check'
    get '/pay', to: 'dashboard#upgrade_pay'
    post '/upgrade', to: 'dashboard#upgrade'
    get '/get_tutor', to: 'dashboard#be_my_tutor'
    post '/get_tutor', to: 'dashboard#assign_tutor'
    get 'social', to: 'dashboard#social'
    get '/test', to: 'dashboard#testing'
  end

  get 'coupon', to: "static#coupon"
  get 'unavailable', to: 'static#unavailable'
  get 'how', to: 'static#how'
  root 'static#welcome'

end
