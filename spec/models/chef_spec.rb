require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
    it { should have_many(:ingredient_dishes).through(:dishes)}
    it { should have_many(:ingredients).through(:ingredient_dishes)}
  end

  before :each do
    @chef_1 = Chef.create!(name: "Bobby Flay")
    @chef_2 = Chef.create!(name: "Chef Boyardee")

    @dish_1 = @chef_1.dishes.create!(name: "Shrimp Scampi", description: "Lots of Calabrian Chiles")
    @dish_2 = @chef_1.dishes.create!(name: "Burger", description: "SW style burger")
    @dish_3 = @chef_2.dishes.create!(name: "Ravoli", description: "In a can")
    @dish_4 = @chef_2.dishes.create!(name: "Beefaroni", description: "Beef I think")

    @ingredient_1 = Ingredient.create!(name: "Shrimp", calories: 500)
    @ingredient_2 = Ingredient.create!(name: "Calabrian Chiles", calories: 100)
    @ingredient_3 = Ingredient.create!(name: "Beef", calories: 800)
    @ingredient_4 = Ingredient.create!(name: "Bun", calories: 200)
    @ingredient_5 = Ingredient.create!(name: "Beef", calories: 600)
    @ingredient_6 = Ingredient.create!(name: "Noodles", calories: 200)
    @ingredient_7 = Ingredient.create!(name: "Cheese", calories: 400)
    @ingredient_8 = Ingredient.create!(name: "Sauce", calories: 150)

    IngredientDish.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_1.id)
    IngredientDish.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_2.id)
    IngredientDish.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_3.id)
    IngredientDish.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_4.id)
    IngredientDish.create!(dish_id: @dish_3.id, ingredient_id: @ingredient_5.id)
    IngredientDish.create!(dish_id: @dish_3.id, ingredient_id: @ingredient_6.id)
    IngredientDish.create!(dish_id: @dish_4.id, ingredient_id: @ingredient_7.id)
    IngredientDish.create!(dish_id: @dish_4.id, ingredient_id: @ingredient_8.id)
  end

  describe "Instance Methods" do
    it '#ingredients_distinct_by_chef' do
      expect(@chef_1.ingredients_distinct_by_chef).to eq([@ingredient_1, @ingredient_2, @ingredient_3, @ingredient_4])
      expect(@chef_2.ingredients_distinct_by_chef).to eq([@ingredient_5, @ingredient_6, @ingredient_7, @ingredient_8])
    end
  end
end
