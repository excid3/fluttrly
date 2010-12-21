Fluttr::Application.routes.draw do

  match 'sms', :to => "sms", :via => :post
  match 'features', :to => "tasks#features", :as => "features"

  resources :tasks
  
  match ':name', :to => "tasks#index", :as => "index"

  root :to => "tasks#home"
end
