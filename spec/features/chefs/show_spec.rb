require 'rails_helper'

RSpec.describe 'chef show page' do
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
    @ingredient_5 = Ingredient.create!(name: "Stuff", calories: 600)
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

#   As a visitor
# When I visit a chef's show page
# I see the name of that chef
# And I see a link to view a list of all ingredients that this chef uses in their dishes.
# When I click on that link
# I'm taken to a chef's ingredient index page
# and I can see a unique list of names of all the ingredients that this chef uses.
  describe 'user story 3' do
    it 'I see the name of that chef' do
      visit chef_path(@chef_1)

      expect(page).to have_content(@chef_1.name)
      expect(page).to_not have_content(@chef_2.name)

      visit chef_path(@chef_2)

      expect(page).to have_content(@chef_2.name)
      expect(page).to_not have_content(@chef_1.name)
    end

    it 'I see a link to view a list of all ingredients that this chef uses in their dishes' do
      visit chef_path(@chef_1)

      find_link({text: "Ingredients Index", href: "/chefs/#{@chef_1.id}/ingredients"}).visible?

      visit chef_path(@chef_2)

      find_link({text: "Ingredients Index", href: "/chefs/#{@chef_2.id}/ingredients"}).visible?
    end

    it 'When I click on that link I am taken to a chefs ingredient index page' do
      visit chef_path(@chef_1)

      click_link("Ingredients Index")

      expect(current_path).to eq("/chefs/#{@chef_1.id}/ingredients")
    end

    it 'I can see a unique list of names of all the ingredients that this chef uses' do
      visit "/chefs/#{@chef_1.id}/ingredients"
      save_and_open_page
      within("#chef-ingredients") do
        expect(page).to have_content(@ingredient_1.name)
        expect(page).to have_content(@ingredient_2.name)
        expect(page).to have_content(@ingredient_3.name)
        expect(page).to have_content(@ingredient_4.name)
        expect(page).to_not have_content(@ingredient_5.name)
        expect(page).to_not have_content(@ingredient_6.name)
        expect(page).to_not have_content(@ingredient_7.name)
        expect(page).to_not have_content(@ingredient_8.name)
      end

      visit "/chefs/#{@chef_2.id}/ingredients"

      within("#chef-ingredients") do
        expect(page).to have_content(@ingredient_5.name)
        expect(page).to have_content(@ingredient_6.name)
        expect(page).to have_content(@ingredient_7.name)
        expect(page).to have_content(@ingredient_8.name)
        expect(page).to_not have_content(@ingredient_1.name)
        expect(page).to_not have_content(@ingredient_2.name)
        expect(page).to_not have_content(@ingredient_3.name)
        expect(page).to_not have_content(@ingredient_4.name)
      end
    end
  end
end
