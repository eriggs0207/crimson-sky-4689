class DishesController < ApplicationController

  def show
    @chef = Chef.find(params[:id])
    @dish = Dish.find(params[:id])
  end

end
