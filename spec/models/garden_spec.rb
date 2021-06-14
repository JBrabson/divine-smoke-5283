require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many :plots }
    it { should have_many(:plants).through(:plots)}
  end

  describe 'instance methods' do
    it '#unique_and_short_harvest' do
      jennys = Garden.create!(name: "Jenny's Gargantuan Garden", organic: true)
      plot1 = jennys.plots.create!(number: 1, size: "Small", direction: "Easy to the East")
      plot2 = jennys.plots.create!(number: 2, size: "Medium", direction: "Due North")
      cucumber = plot1.plants.create!(name: "Cucumber", description: "English, Less bitter than the plain old", days_to_harvest: 3)
      strawberry = plot1.plants.create!(name: "Strawberry", description: "Seeded, best in Spring", days_to_harvest: 5)
      kale = plot2.plants.create!(name: "Kale", description: "Not good on taste buds, but good on health", days_to_harvest: 22)
      plot1.plants << kale
      plot2.plants << cucumber

      expect(jennys.unique_and_short_harvest).to eq([cucumber, kale, strawberry])
    end
  end

end
