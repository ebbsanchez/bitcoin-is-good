Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  scope '/dashboard' do
  	get '', to: 'dashboard#home'
  	get '', to: 'dashboard#balance'
  end
  root 'static#welcome'
end
