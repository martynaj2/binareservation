Rails.application.routes.draw do

	root 'home#welcome'

	devise_for :users, :path_prefix => 'my', controllers: { registrations: "registrations" }
	resources :home
	resources :reservations
	resources :halls
	# resources :users
	# resources :admins
	resources :admins do
  	member do
      patch :verify
      put :verify
    end
	end
	get '/my_reservations', to: 'reservations#user_index', as: :user_reservations
	get '/confirm', to: 'reservations#confirm', as: :confirm_reservation
	post '/overwrite', to: 'reservations#overwrite', as: :overwrite_reservation
	get '/edit_confirm', to: 'reservations#edit_confirm', as: :edit_confirm_reservation
	post '/edit_overwrite', to: 'reservations#edit_overwrite', as: :edit_overwrite_reservation
	post '/verify_all', to: 'admins#verify_all', as: :verify_all_admin
	get '/users', to: 'admins#index', as: :administrator
	get '/my_profile', to: 'users#index', as: :profile
	resources :users do
  	member do
      patch :vacation
      put :vacation
    end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
