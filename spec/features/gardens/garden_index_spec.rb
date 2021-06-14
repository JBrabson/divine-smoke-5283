require 'rails_helper'
RSpec.describe 'Gardens Index Page' do
  it 'displays each garden name and link to show page' do
    jennys = Garden.create!(name: "Jenny's Gargantuan Garden", organic: true)
    nans = Garden.create!(name: "Nan's Nashville Garden", organic: false)
    bees = Garden.create!(name: "Bee's Knees Botanical Garden", organic: false)

    visit '/gardens'

    expect(page).to have_link("What We've Got Growing", count: 3)
    
    within("#garden-#{jennys.id}") do
      expect(page).to have_content(jennys.name)
      click_link("What We've Got Growing")
    end

    expect(current_path).to eq("/gardens/#{jennys.id}")

  end
end
