Rails.application.routes.draw do

	root 'home#welcome'

	devise_for :users, :path_prefix => 'my', controllers: { registrations: "registrations" }
	resources :home
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
	get '/halls/small', to: 'halls#small', as: :small_hall
	get '/halls/medium', to: 'halls#medium', as: :medium_hall
	get '/halls/large', to: 'halls#large', as: :large_hall
	get '/halls/extra_large', to: 'halls#extra_large', as: :extra_large_hall
	get '/my_reservations', to: 'reservations#user_index', as: :user_reservations
	get '/confirm', to: 'reservations#confirm', as: :confirm_reservation
	post '/overwrite', to: 'reservations#overwrite', as: :overwrite_reservation
	get '/edit_confirm', to: 'reservations#edit_confirm', as: :edit_confirm_reservation
	post '/edit_overwrite', to: 'reservations#edit_overwrite', as: :edit_overwrite_reservation

	resources :users do
  	member do
      patch :vacation
      put :vacation
    end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
