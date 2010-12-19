Fluttr::Application.routes.draw do
  resources :tasks
  
  match ':name', :to => "tasks#index", :as => "index"
	match ":name/text_update" => "tasks#text_update"

  root :to => "tasks#home"


end
