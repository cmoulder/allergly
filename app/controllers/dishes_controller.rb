class DishesController < ApplicationController
  def index
    require "rinruby"
    @dishes = Dish.all

    render("dishes/index.html.erb")
  end

  def show
    @dish = Dish.find(params[:id])

    render("dishes/show.html.erb")
  end

  def new
    @dish = Dish.new
    @name = params[:name]

    render("dishes/new.html.erb")
  end

  def ndb_import
    require 'open-uri'

    @dish = Dish.new

    base_url="https://api.nal.usda.gov/ndb/V2/reports?ndbno="
    closing_url="&type=f&format=json&api_key=jienrSsAT0eXVCMBkBkqxgJHiqU6lPlZGxZ38f7Q"
    final_url =  base_url + params[:ndb].to_s.strip + closing_url
    parsed_data = JSON.parse(open(final_url).read)

    @name = parsed_data["foods"][0]["food"]["desc"]["name"].downcase
    ing = parsed_data["foods"][0]["food"]["ing"]["desc"]

    #@numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)
    #
    @ingredients = ing.downcase.gsub('.', ',').gsub(' (',', ').gsub(' [',', ').gsub(/[^a-z0-9,\s]/i, '').strip
    #.gsub(' /[',', ')
    #.gsub(/[^a-z0-9,\s]/i, '')
    #replace period with comma, remove ending period, if () or [] remove preceeding work

    render("dishes/new.html.erb")
  end

  def create

    @dish = Dish.new
    newingarray =  Array.new
    @existingingarray = Array.new

    @dish.name = params[:name]
    @dish.created_by = current_user.id
    save_status = @dish.save

    if save_status == true
      ing = params[:ingredients].split(',').map(&:strip)
      ing.each do |oneingred|
        if Ingredient.where(:name => oneingred).count > 0
          @existingingarray.push(oneingred)
        else
          newingarray.push(oneingred)
        end
      end
      @newing = newingarray.uniq.join(", ")
      @existingingarray = @existingingarray.uniq
      @existinging = @existingingarray.join(", ")


      #redirect_to("/dishes/#{@dish.id}", :notice => "Dish created successfully.")
      render("dishes/finalize.html.erb", :notice => "We didn't recognize some of your ingredients")
    else
      render("dishes/new.html.erb", :notice => "Your dish already exists")
    end

  end

  def finalize
    dishid = params[:dishid]
    newing = params[:new]
    existinging = params[:existing]

    newingredients = newing.split(',').map(&:strip)
    existingingredients = existinging.split(',').map(&:strip)
    allingredients = existingingredients + newingredients

    #Add new ing to ing database
    newingredients.each do |ingredient|
      if Ingredient.where(:name => ingredient).count < 1
        ing = Ingredient.new
        ing.name = ingredient
        ing.save
      end
    end

    #add all ingredients to recipe

    allingredients.each do |ingredient|
      thisrecipe = Recipe.new
      thisrecipe.dish_id = dishid
      thisrecipe.ingredient_id = Ingredient.find_by(:name => ingredient).id
      thisrecipe.save
    end

    redirect_to("/dishes/#{dishid}", :notice => "Dish created successfully.")
  end

  def edit
    @dish = Dish.find(params[:id])


    render("dishes/edit.html.erb")
  end

  def update
    @dish = Dish.find(params[:id])
    @dish.name = params[:name]
    params[:ingredients]

    newingarray =  Array.new
    @existingingarray = Array.new

    save_status = @dish.save


    if save_status == true
      @dish.recipes.destroy_all

      ing = params[:ingredients].split(',').map(&:strip)
      ing.each do |oneingred|
        if Ingredient.where(:name => oneingred).count > 0
          @existingingarray.push(oneingred)
        else
          newingarray.push(oneingred)
        end
      end
      @newing = newingarray.uniq.join(", ")
      @existingingarray = @existingingarray.uniq
      @existinging = @existingingarray.join(", ")


      #redirect_to("/dishes/#{@dish.id}", :notice => "Dish created successfully.")
      render("dishes/finalize.html.erb", :notice => "We didn't recognize some of your ingredients")
    else
      render("dishes/new.html.erb", :notice => "Your dish already exists")
    end



    #
    # save_status = @dish.save
    #
    # if save_status == true
    #   redirect_to("/dishes/#{@dish.id}", :notice => "Dish updated successfully.")
    # else
    #   render("dishes/edit.html.erb")
    # end

  end

  def destroy
    @dish = Dish.find(params[:id])
    @dish.recipes.destroy_all
    @dish.destroy

    if URI(request.referer).path == "/dishes/#{@dish.id}"
      redirect_to("/", :notice => "Dish deleted.")
    else
      redirect_to(:back, :notice => "Dish deleted.")
    end
  end
end
