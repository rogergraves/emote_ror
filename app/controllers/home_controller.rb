require 'geokit'
class HomeController < ApplicationController
  def index
    @location = GeoKit::Geocoders::MultiGeocoder.geocode(request.ip)
  end
end
