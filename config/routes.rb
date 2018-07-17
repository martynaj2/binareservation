Rails.application.routes.draw do

	root 'home#welcome'

	resources :halls
	devise_for :users, :path_prefix => 'my'
	match '/users',   to: 'users#index',   via: 'get'
	match '/users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
	# resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
