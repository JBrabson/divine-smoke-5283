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

  it 'plants list is unique and only displays plants with less than 100 days to harvest' do
    jennys = Garden.create!(name: "Jenny's Gargantuan Garden", organic: true)
    plot1 = jennys.plots.create!(number: 1, size: "Small", direction: "Easy to the East")
    plot2 = jennys.plots.create!(number: 2, size: "Medium", direction: "Seein' South")
    cucumber = plot1.plants.create!(name: "Cucumber", description: "English, Less bitter than the plain old", days_to_harvest: 3)
    strawberry = plot1.plants.create!(name: "Strawberry", description: "Seeded, best in Spring", days_to_harvest: 5)
    kale = plot2.plants.create!(name: "Kale", description: "Not good on taste buds, but good on health", days_to_harvest: 22)
    brussel = plot2.plants.create!(name: "Brussel Sprouts", description: "Good broiled with garlic", days_to_harvest: 100)
    mango = plot2.plants.create!(name: "Mango", description: "We made it happen and they are growing here", days_to_harvest: 101)
    plot1.plants << kale
    plot2.plants << strawberry
    plot2.plants << cucumber

    visit "/gardens/#{jennys.id}"

    expect(page).to have_content(cucumber.name, count: 1)
    expect(page).to have_content(strawberry.name, count: 1)
    expect(page).to have_content(kale.name, count: 1)
    expect(page).to_not have_content(brussel.name)
    expect(page).to_not have_content(mango.name)
  end

end
