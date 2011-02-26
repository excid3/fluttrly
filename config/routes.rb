Fluttr::Application.routes.draw do
  #resources :name, :constraints => { :name => /[\w-]/}

  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "signup" }
  match "/users" => redirect("/users/edit")

  match 'sms', :to => "tasks#sms", :via => :post
  match 'features', :to => "tasks#features", :as => "features"
  match ':name/lock', :to => "tasks#lock", :via => :post

  resources :tasks
  
  match ':name', :to => "tasks#index", :as => "index"


  root :to => "tasks#home"
end
