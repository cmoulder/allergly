class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    render("recipes/index.html.erb")
  end

  def show
    @recipe = Recipe.find(params[:id])

    render("recipes/show.html.erb")
  end

  def new
    @recipe = Recipe.new

    render("recipes/new.html.erb")
  end

  def create
    @recipe = Recipe.new


    @recipe.dish_id = params[:dish_id]

    @recipe.ingredient_id = params[:ingredient_id]



    save_status = @recipe.save

    if save_status == true
      redirect_to("/recipes/#{@recipe.id}", :notice => "Recipe created successfully.")
    else
      render("recipes/new.html.erb")
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])

    render("recipes/edit.html.erb")
  end

  def update
    @recipe = Recipe.find(params[:id])


    @recipe.dish_id = params[:dish_id]

    @recipe.ingredient_id = params[:ingredient_id]



    save_status = @recipe.save

    if save_status == true
      redirect_to("/recipes/#{@recipe.id}", :notice => "Recipe updated successfully.")
    else
      render("recipes/edit.html.erb")
    end

  end

  def destroy
    @recipe = Recipe.find(params[:id])

    @recipe.destroy

    if URI(request.referer).path == "/recipes/#{@recipe.id}"
      redirect_to("/", :notice => "Recipe deleted.")
    else
      redirect_to(:back, :notice => "Recipe deleted.")
    end
  end
end
