require 'rails_helper'
RSpec.describe 'Garden Show Page' do

  it 'displays list of plants that are planted in plots of that garden only' do
    jennys = Garden.create!(name: "Jenny's Gargantuan Garden", organic: true)
    bees = Garden.create!(name: "Bee's Knees Botanical", organic: false)
    plot2 = jennys.plots.create!(number: 2, size: "Medium", direction: "Easy to the East")
    plot3 = bees.plots.create!(number: 3, size: "Large", direction: "Due North (Where the Polar Bears Are)")
    cucumber = plot2.plants.create!(name: "Cucumber", description: "English, Less bitter than the plain old", days_to_harvest: 3)
    strawberry = plot2.plants.create!(name: "Strawberry", description: "Seeded, best in Spring", days_to_harvest: 5)
    kale = plot3.plants.create!(name: "Kale", description: "Not good on taste buds, but good on health", days_to_harvest: 22)

    visit "/gardens/#{jennys.id}"

    expect(page).to have_content(jennys.name)
    expect(page).to_not have_content(bees.name)
    expect(page).to have_content(cucumber.name)
    expect(page).to have_content(strawberry.name)
    expect(page).to_not have_content(kale.name)
  end

  it 'plants list is unique' do
    jennys = Garden.create!(name: "Jenny's Gargantuan Garden", organic: true)
    plot1 = jennys.plots.create!(number: 2, size: "Medium", direction: "Easy to the East")
    cucumber = plot2.plants.create!(name: "Cucumber", description: "English, Less bitter than the plain old", days_to_harvest: 3)
    strawberry = plot2.plants.create!(name: "Strawberry", description: "Seeded, best in Spring", days_to_harvest: 5)
    kale = plot3.plants.create!(name: "Kale", description: "Not good on taste buds, but good on health", days_to_harvest: 22)
    plot1 = jennys.plots.create!(number: 1, size: "Small", direction: "Seein' South")
    plot1.plants << cucumber
    plot1.plants << strawberry
    plot3.plants << cucumber

    visit "/gardens/#{jennys.id}"

    expect(page).to have_content(cucumber.name, count: 1)
    expect(page).to have_content(strawberry.name, count: 1)
    expect(page).to have_content(kale.name, count: 1)
  end

end
