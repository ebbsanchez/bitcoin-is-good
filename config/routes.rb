Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  scope '/dashboard' do
  	get '', to: 'dashboard#home'
  	get '/upgrade', to: 'dashboard#upgrade_page'
  	post '/upgrade', to: 'dashboard#upgrade'

  end
  root 'static#welcome'
end
