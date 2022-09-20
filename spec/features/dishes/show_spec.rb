require 'rails_helper'

RSpec.describe 'dish show page' do
  before :each do
    @chef_1 = Chef.create!(name: "Bobby Flay")
    @dish_1 = @chef_1.dishes.create!(name: "Shrimp Scampi", description: "Lots of Calabrian Chiles")
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
    end
  end
end
