Rails.application.routes.draw do
  
  get 'users/new'
  	# devise_for :users
	root :to => "news#index"
	resources :news do
		collection do
			post :update_viewer
		end
	end
	resources :sessions
	resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
