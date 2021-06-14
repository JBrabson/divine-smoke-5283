class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def unique_and_short_harvest
    plants.select('plants.*').where("days_to_harvest < 100").distinct.order(:name)
  end
end
