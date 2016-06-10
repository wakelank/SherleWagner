class ShowroomsController < ApplicationController
  def index
    @regions = Showroom.regions
    @regions.map! { |region| Region.new(name: region, showrooms: Showroom.where(region: region)) }
  end
end
