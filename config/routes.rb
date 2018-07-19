Rails.application.routes.draw do

	root 'home#welcome'

	devise_for :users, :path_prefix => 'my', controllers: { registrations: "registrations" }
	resources :reservations
	resources :halls
	resources :users
	resource :user, only: [:edit] do
	  collection do
	    patch 'update_password'
	  end
	end
	resources :admins
	resources :admins do
  	member do
      patch :verify
      put :verify
    end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
