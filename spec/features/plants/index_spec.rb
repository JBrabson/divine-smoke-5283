require 'rails_helper'
RSpec.describe 'Plant Index' do
  before :each do
    @nans = Garden.create!(name: "Nan's Nashville Garden", organic: true)
    @jennys = Garden.create!(name: "Jenny's Gargantuan Garden", organic: true)
    @bees = Garden.create!(name: "Bee's Knees Botanical", organic: false)
    @plot1 = @nans.plots.create!(number: 1, size: "Small", direction: "To the Wild West")
    @plot2 = @jennys.plots.create!(number: 2, size: "Medium", direction: "Easy to the East")
    @plot3 = @bees.plots.create!(number: 3, size: "Large", direction: "Due North (Where the Polar Bears Are)")
    @tomato = @plot1.plants.create!(name: "Tomato", description: "Romas, Thrive when watered adequately", days_to_harvest: 15)
    @lettuce = @plot1.plants.create!(name: "Lettuce", description: "Romaine, Better without Pesticides", days_to_harvest: 13)
    @cucumber = @plot2.plants.create!(name: "Cucumber", description: "English, Less bitter than the plain old", days_to_harvest: 3)
    @strawberry = @plot2.plants.create!(name: "Strawberry", description: "Seeded, best in Spring", days_to_harvest: 5)
    @kale = @plot3.plants.create!(name: "Kale", description: "Not good on taste buds, but good on health", days_to_harvest: 22)
    visit "/plots"
  end

  it 'displays all plants available' do
    expect(page).to have_content(@tomato.name)
    expect(page).to have_content(@lettuce.name)
    expect(page).to have_content(@cucumber.name)
    expect(page).to have_content(@strawberry.name)
    expect(page).to have_content(@kale.name)
  end
end
