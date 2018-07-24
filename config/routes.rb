Rails.application.routes.draw do

	root 'home#welcome'

	devise_for :users, :path_prefix => 'my', controllers: { registrations: "registrations" }
	resources :reservations
	resources :halls
	resources :users
	resources :admins
	resources :admins do
  	member do
      patch :verify
      put :verify
    end
	end
	get '/my_reservations', to: 'reservations#user_index', as: :user_reservations
	get '/confirm', to: 'reservations#confirm', as: :confirm_reservation
	post '/override', to: 'reservations#override', as: :override_reservation
	get '/confirm_update', to: 'reservations#confirm_update', as: :confirm_update_reservation
	post '/override_update', to: 'reservations#override_update', as: :override_update_reservation
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
