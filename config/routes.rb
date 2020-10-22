Rails.application.routes.draw do
  
  namespace :v1 do
  	resources :appointments
    resources :patients
    resources :doctors
    resources :users, only: :create do
	  collection do
	    post 'login'
	    patch 'logout'
	  end
	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
