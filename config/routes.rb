Rails.application.routes.draw do

	root 'home#welcome'
	resources :reservations
	resources :halls
	devise_for :users, :path_prefix => 'my'

	resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
