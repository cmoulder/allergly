class MealsController < ApplicationController
  def index
    @meals = Meal.all

    render("meals/index.html.erb")
  end

  def show
    @meal = Meal.find(params[:id])

    render("meals/show.html.erb")
  end

  def new
    @meal = Meal.new

    render("meals/new.html.erb")
  end

  def create
    @meal = Meal.new


    @meal.user_id = params[:user_id]

    @meal.date = params[:date]

    @meal.mood = params[:mood]



    save_status = @meal.save

    if save_status == true
      redirect_to("/meals/#{@meal.id}", :notice => "Meal created successfully.")
    else
      render("meals/new.html.erb")
    end

  end

  def edit
    @meal = Meal.find(params[:id])

    render("meals/edit.html.erb")
  end

  def update
    @meal = Meal.find(params[:id])


    @meal.user_id = params[:user_id]

    @meal.date = params[:date]

    @meal.mood = params[:mood]



    save_status = @meal.save

    if save_status == true
      redirect_to("/meals/#{@meal.id}", :notice => "Meal updated successfully.")
    else
      render("meals/edit.html.erb")
    end

  end

  def destroy
    @meal = Meal.find(params[:id])

    @meal.destroy

    if URI(request.referer).path == "/meals/#{@meal.id}"
      redirect_to("/", :notice => "Meal deleted.")
    else
      redirect_to(:back, :notice => "Meal deleted.")
    end
  end
end
