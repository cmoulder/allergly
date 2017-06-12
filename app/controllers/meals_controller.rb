class MealsController < ApplicationController
  def index
    @meals = Meal.where(:user_id=>current_user.id).order('date')

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
    @newdishesarray =  Array.new
    @existingdishesarray = Array.new
    @meal = Meal.new

    @meal.user_id = current_user.id
    tempdate=params[:date].to_s
    @meal.date = tempdate[3,2]+'/'+tempdate[0,2]+'/'+tempdate[6,4]
    @meal.mood = params[:mood]

    save_status = @meal.save

    if save_status == true
      dishes = params[:dishes].split(',').map(&:strip)..map(&:downcase)
      dishes.each do |dish|
        if Dish.where(:name => dish).count > 0
          @existingdishesarray.push(dish)
        else
          @newdishesarray.push(dish)
        end
      end
      @newdishes = @newdishesarray.uniq.join(", ")
      @existingdishesarray = @existingdishesarray.uniq
      @existingdishes = @existingdishesarray.join(", ")

      if save_status == true
        render("meals/finalize.html.erb", :notice => "We didn't recognize some of your dishes")
      else
        render("meals/new.html.erb")
      end

    end
  end

  def finalize_meal
    mealid = params[:mealid]
    newd = params[:new]
    existingd = params[:existing]

    newdishes = newd.split(',').map(&:strip).downcase
    existingingdishes = existingd.split(',').map(&:strip).map(&:downcase)
    alldishes = existingingdishes + newdishes

    #add all dishes to meal through menu

    alldishes.each do |dish|
      if Dish.where(:name => dish).count > 0
        thismenu = Menu.new
        thismenu.meal_id = mealid
        thismenu.dish_id = Dish.find_by(:name => dish).id
        thismenu.save
      end
    end

    redirect_to("/meals/#{mealid}", :notice => "Meal created successfully.")

  end


  def edit
    @meal = Meal.find(params[:id])

    render("meals/edit.html.erb")
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.date = params[:date]
    @meal.mood = params[:mood]
    @meal.dishes.destroy_all

    @newdishesarray =  Array.new
    @existingdishesarray = Array.new

    tempdate=params[:date].to_s
    @meal.date = tempdate[3,2]+'/'+tempdate[0,2]+'/'+tempdate[6,4]
    @meal.mood = params[:mood]

    save_status = @meal.save

    if save_status == true
      dishes = params[:dishes].split(',').map(&:strip).map(&:downcase)
      dishes.each do |dish|
        if Dish.where(:name => dish).count > 0
          @existingdishesarray.push(dish)
        else
          @newdishesarray.push(dish)
        end
      end
      @newdishes = @newdishesarray.uniq.join(", ")
      @existingdishesarray = @existingdishesarray.uniq
      @existingdishes = @existingdishesarray.join(", ")

      if save_status == true
        render("meals/finalize.html.erb", :notice => "We didn't recognize some of your dishes")
      else
        render("meals/new.html.erb")
      end

    end


    # save_status = @meal.save
    #
    # if save_status == true
    #   redirect_to("/meals/#{@meal.id}", :notice => "Meal updated successfully.")
    # else
    #   render("meals/edit.html.erb")
    # end

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
