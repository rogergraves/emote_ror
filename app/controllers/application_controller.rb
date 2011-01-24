require 'geokit'
class ApplicationController < ActionController::Base
  helper 'application'
  
  protect_from_forgery
  before_filter :geocode_by_ip
  
protected

  def geocode_by_ip
    if session[:geo_location].nil? || session[:ip_address] != request.ip
      session[:geo_location] = GeoKit::Geocoders::MultiGeocoder.geocode(request.ip)
      session[:ip_address] = request.ip
    end
  end

  #Overrides the path where user is redirected after successful login
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.kind_of?(User)
      account_surveys_path
    else #Admins [for future]
      super
    end
  end

end
