class ShowroomsController < ApplicationController
  def index
    @regions = Showroom.regions
    @regions.map! { |region| Region.new(name: region, showrooms: Showroom.where(region: region).order(:order)) }
    @regional_offices = Showroom.where(regional_office: true).order(:order)
  end

end
