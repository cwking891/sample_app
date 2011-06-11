SampleApp::Application.routes.draw do
  resources :users
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]

  match "/home",		:to => "pages#home"

  match "/contact",	:to => "pages#contact"
  match "/help",		:to => "pages#help"
  match "/about",		:to => "pages#about"
  root			:to => "pages#home"

  match '/signup',      :to => 'users#new'
  match '/signin',      :to => 'sessions#new'
  match '/signout',     :to => 'sessions#destroy'

end
