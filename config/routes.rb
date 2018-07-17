Rails.application.routes.draw do

	root 'home#welcome'

	resources :halls
	match '/users',   to: 'users#index',   via: 'get'
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
