require 'rails_helper'
RSpec.describe 'Plots Index Page' do
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

  it 'displays list of all plot numbers, with names of each plant specific to that plot listed underneath' do
    within("#plot-#{@plot1.id}") do
      expect(page).to have_content("Plot Number: #{@plot1.number}")
      expect(page).to have_content(@tomato.name)
      expect(page).to have_content(@lettuce.name)
      expect(page).to_not have_content(@cucumber.name)
      expect(page).to_not have_content(@strawberry.name)
      expect(page).to_not have_content(@kale.name)
    end

    within("#plot-#{@plot2.id}") do
      expect(page).to have_content("Plot Number: #{@plot2.number}")
      expect(page).to have_content(@cucumber.name)
      expect(page).to have_content(@strawberry.name)
      expect(page).to_not have_content(@kale.name)
      expect(page).to_not have_content(@tomato.name)
      expect(page).to_not have_content(@lettuce.name)
    end

    within("#plot-#{@plot3.id}") do
      expect(page).to have_content("Plot Number: #{@plot3.number}")
      expect(page).to have_content(@kale.name)
      expect(page).to_not have_content(@tomato.name)
      expect(page).to_not have_content(@lettuce.name)
      expect(page).to_not have_content(@cucumber.name)
      expect(page).to_not have_content(@strawberry.name)
    end
  end

  describe 'Remove Plant from a Plot' do
    it 'displays delete link next to each plant regardless of plot' do

      within("#plant-#{@lettuce.id}") do
        expect(page).to have_link "Send This Plant Packin' (Remove This Plant)"
      end

      within("#plant-#{@cucumber.id}") do
        expect(page).to have_link "Send This Plant Packin' (Remove This Plant)"
      end

      within("#plant-#{@kale.id}") do
        expect(page).to have_link "Send This Plant Packin' (Remove This Plant)"
      end
    end

    it 'delete link will redirect to plot index page where deleted plant will no longer display under plot deleted from' do
      within("#plant-#{@tomato.id}") do
        click_link "Send This Plant Packin' (Remove This Plant)"
      end

      expect(current_path).to eq('/plots')
        within("#plot-#{@plot1.id}") do
          expect(page).to_not have_content(@tomato.name)
          expect(page).to have_content(@lettuce.name)
        end
    end


  end
end
