require 'rails_helper'

require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it { should have_many :plot_plants }
    it { should have_many(:plots).through(:plot_plants) }
    it { should have_many(:gardens).through(:plots) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end
  #
  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
