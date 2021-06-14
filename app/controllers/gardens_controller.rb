class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.unique_and_short_harvest
  end
end
