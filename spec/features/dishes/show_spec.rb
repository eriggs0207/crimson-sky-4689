require 'rails_helper'

RSpec.describe 'dish show page' do
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

#   As a visitor
# When I visit a dish's show page
# I see the dish’s name and description
# And I see a list of ingredients for that dish
# And I see the chef's name.
  describe 'user story 1' do
    it 'I see the dish’s name and description' do
      visit dish_path(@dish_1)

      within("#dish-info") do
        expect(page).to have_content(@dish_1.name)
        expect(page).to have_content(@dish_1.description)
      end

      visit dish_path(@dish_2)

      within("#dish-info") do
        expect(page).to have_content(@dish_2.name)
        expect(page).to have_content(@dish_2.description)
      end
    end

    it 'And I see a list of ingredients for that dish' do
      visit dish_path(@dish_1)

      within("#dish-ingredients") do
        expect(page).to have_content(@ingredient_1.name)
        expect(page).to have_content(@ingredient_1.calories)
        expect(page).to have_content(@ingredient_2.name)
        expect(page).to have_content(@ingredient_2.calories)
      end

      visit dish_path(@dish_2)

      within("#dish-ingredients") do
        expect(page).to have_content(@ingredient_3.name)
        expect(page).to have_content(@ingredient_3.calories)
        expect(page).to have_content(@ingredient_4.name)
        expect(page).to have_content(@ingredient_4.calories)
      end
    end

    it 'I see the chefs name' do
      visit dish_path(@dish_1)

      expect(page).to have_content(@chef_1.name)

      visit dish_path(@dish_2)

      expect(page).to have_content(@chef_2.name)
    end
  end
end
