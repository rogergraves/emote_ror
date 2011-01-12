require 'geokit'
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :geocode_by_ip
  
  protected
    def geocode_by_ip
      if session[:geo_location].nil? || session[:ip_address] != request.ip
        session[:geo_location] = GeoKit::Geocoders::MultiGeocoder.geocode(request.ip)
        session[:ip_address] = request.ip
      end
    end
end
