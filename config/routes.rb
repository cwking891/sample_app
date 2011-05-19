SampleApp::Application.routes.draw do
	resources :users

  match "/signup",		:to => "users#new"
	
  get "pages/home"
	match "/home",			:to => "pages#home"

	match "/contact",		:to => "pages#contact"
	match "/help",			:to => "pages#help"
	match "/about",			:to => "pages#about"
	root								:to => "pages#home"

	end
