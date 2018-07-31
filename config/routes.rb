Rails.application.routes.draw do

	root 'home#welcome'

	devise_for :users, :path_prefix => 'my', controllers: { registrations: "registrations" }
	resources :home
	resources :reservations
	resources :halls

	resources :groups

	resources :admins do
  	member do
      patch :verify
      put :verify
    end
	end
	get '/my_reservations', to: 'reservations#user_index', as: :user_reservations
	get '/my_groups', to: 'groups#user_index', as: :user_groups
	get '/confirm', to: 'reservations#confirm', as: :confirm_reservation
	post '/overwrite', to: 'reservations#overwrite', as: :overwrite_reservation
	get '/edit_confirm', to: 'reservations#edit_confirm', as: :edit_confirm_reservation
	post '/edit_overwrite', to: 'reservations#edit_overwrite', as: :edit_overwrite_reservation
	post '/verify_all', to: 'admins#verify_all', as: :verify_all_admin
	get '/users', to: 'admins#index', as: :administrator
	get 'user/:id/edit', to: 'admins#edit', as: :edit_administrator
	get '/my_profile', to: 'users#index', as: :profile
	get '/my_profile/:id/edit', to: 'users#edit', as: :edit_profile
	resources :users do
  	member do
      patch :vacation
      put :vacation
    end
	end

	if Rails.env.development?
		require 'sidekiq/web'
		mount Sidekiq::Web => '/sidekiq'
	end
end
