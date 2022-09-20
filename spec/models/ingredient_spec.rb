require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'relationships' do
  it { should have_many :ingredient_dishes}
  it { should have_many(:dishes).through(:ingredient_dishes)}
  end

  before :each do
    @chef_1 = Chef.create!(name: "Bobby Flay")
    @chef_2 = Chef.create!(name: "Chef Boyardee")

    @dish_1 = @chef_1.dishes.create!(name: "Shrimp Scampi", description: "Lots of Calabrian Chiles")
    @dish_2 = @chef_2.dishes.create!(name: "Beefaroni", description: "Beef I think")

    @ingredient_1 = Ingredient.create!(name: "Shrimp", calories: 500)
    @ingredient_2 = Ingredient.create!(name: "Calabrian Chiles", calories: 100)
    @ingredient_3 = Ingredient.create!(name: "Beef", calories: 600)
    @ingredient_4 = Ingredient.create!(name: "Noodles", calories: 200)

    IngredientDish.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_1.id)
    IngredientDish.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_2.id)
    IngredientDish.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_3.id)
    IngredientDish.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_4.id)
  end

  describe 'Class Methods' do
    it '#total_calories' do
      expect(Ingredient.total_calories).to eq(1400)
    end
  end
end
