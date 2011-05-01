SampleApp::Application.routes.draw do
<<<<<<< HEAD

  get "users/new"
  match "/users",			:to => "users#new"
	
  get "pages/home"
	match "/home",			:to => "pages#home"
	match "/contact",		:to => "pages#contact"
	match "/help",			:to => "pages#help"
	match "/about",			:to => "pages#about"
	root								:to => "pages#home"
=======
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
	root :to => 'pages#home'
>>>>>>> css-added

	end
