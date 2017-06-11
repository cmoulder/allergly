Rails.application.routes.draw do
  # Routes for the Ingredient resource:
  # CREATE
  get "/ingredients/new", :controller => "ingredients", :action => "new"
  post "/create_ingredient", :controller => "ingredients", :action => "create"

  # READ
  get "/ingredients", :controller => "ingredients", :action => "index"
  get "/ingredients/:id", :controller => "ingredients", :action => "show"

  # UPDATE
  get "/ingredients/:id/edit", :controller => "ingredients", :action => "edit"
  post "/update_ingredient/:id", :controller => "ingredients", :action => "update"

  # DELETE
  get "/delete_ingredient/:id", :controller => "ingredients", :action => "destroy"
  #------------------------------

  # Routes for the Dish resource:
  # CREATE

  get "/dishes/new", :controller => "dishes", :action => "new"
  get "/dishes/new/:name", :controller => "dishes", :action => "new"
  post "/create_dish", :controller => "dishes", :action => "create"
  post "/finalize_dish", :controller => "dishes", :action => "finalize"
  post "/ndb_import", :controller => "dishes", :action => "ndb_import"

  # READ
  get "/dishes", :controller => "dishes", :action => "index"
  get "/dishes/:id", :controller => "dishes", :action => "show"

  # UPDATE
  get "/dishes/:id/edit", :controller => "dishes", :action => "edit"
  post "/update_dish/:id", :controller => "dishes", :action => "update"

  # DELETE
  get "/delete_dish/:id", :controller => "dishes", :action => "destroy"
  #------------------------------

  # Routes for the Recipe resource:
  # CREATE
  get "/recipes/new", :controller => "recipes", :action => "new"
  post "/create_recipe", :controller => "recipes", :action => "create"

  # READ
  get "/recipes", :controller => "recipes", :action => "index"
  get "/recipes/:id", :controller => "recipes", :action => "show"

  # UPDATE
  get "/recipes/:id/edit", :controller => "recipes", :action => "edit"
  post "/update_recipe/:id", :controller => "recipes", :action => "update"

  # DELETE
  get "/delete_recipe/:id", :controller => "recipes", :action => "destroy"
  #------------------------------

  # Routes for the Menu resource:
  # CREATE
  get "/menus/new", :controller => "menus", :action => "new"
  post "/create_menu", :controller => "menus", :action => "create"

  # READ
  get "/menus", :controller => "menus", :action => "index"
  get "/menus/:id", :controller => "menus", :action => "show"

  # UPDATE
  get "/menus/:id/edit", :controller => "menus", :action => "edit"
  post "/update_menu/:id", :controller => "menus", :action => "update"

  # DELETE
  get "/delete_menu/:id", :controller => "menus", :action => "destroy"
  #------------------------------

  #Routes for Analysis
  get "/analysis", :controller => "analysis", :action => "index"


  # Routes for the Meal resource:
  # CREATE
  get "/meals/new", :controller => "meals", :action => "new"
  post "/create_meal", :controller => "meals", :action => "create"
  post "/finalize_meal", :controller => "meals", :action => "finalize_meal"

  # READ
  get "/meals", :controller => "meals", :action => "index"
  get "/meals/:id", :controller => "meals", :action => "show"

  # UPDATE
  get "/meals/:id/edit", :controller => "meals", :action => "edit"
  post "/update_meal/:id", :controller => "meals", :action => "update"

  # DELETE
  get "/delete_meal/:id", :controller => "meals", :action => "destroy"
  #------------------------------

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'meals#index'

end
