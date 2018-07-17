Rails.application.routes.draw do

	root 'home#welcome'

	devise_for :users, :path_prefix => 'my'
	resources :reservations
	resources :halls
	resources :users
	resources :verify
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
