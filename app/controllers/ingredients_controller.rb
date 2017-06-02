class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all

    render("ingredients/index.html.erb")
  end

  def show
    @ingredient = Ingredient.find(params[:id])

    render("ingredients/show.html.erb")
  end

  def new
    @ingredient = Ingredient.new

    render("ingredients/new.html.erb")
  end

  def create
    @ingredient = Ingredient.new


    @ingredient.name = params[:name]



    save_status = @ingredient.save

    if save_status == true
      redirect_to("/ingredients/#{@ingredient.id}", :notice => "Ingredient created successfully.")
    else
      render("ingredients/new.html.erb")
    end

  end

  def edit
    @ingredient = Ingredient.find(params[:id])

    render("ingredients/edit.html.erb")
  end

  def update
    @ingredient = Ingredient.find(params[:id])


    @ingredient.name = params[:name]



    save_status = @ingredient.save

    if save_status == true
      redirect_to("/ingredients/#{@ingredient.id}", :notice => "Ingredient updated successfully.")
    else
      render("ingredients/edit.html.erb")
    end

  end

  def destroy
    @ingredient = Ingredient.find(params[:id])

    @ingredient.destroy

    if URI(request.referer).path == "/ingredients/#{@ingredient.id}"
      redirect_to("/", :notice => "Ingredient deleted.")
    else
      redirect_to(:back, :notice => "Ingredient deleted.")
    end
  end
end
