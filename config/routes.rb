Fluttr::Application.routes.draw do

  match 'features', :to => "tasks#features", :as => "features"

  resources :tasks
  
  match ':name', :to => "tasks#index", :as => "index"
  match ":name/text_update" => "tasks#text_update"

  root :to => "tasks#home"
end
