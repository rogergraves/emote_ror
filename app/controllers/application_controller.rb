require 'geokit'
class ApplicationController < ActionController::Base
  helper 'application'
  
  protect_from_forgery
  before_filter :geocode_by_ip
  
  layout :layout_by_resource 
  
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
      super(resource_or_scope)
    end
  end

  #Overrides the path where user is redirected after initial password setup
  def after_update_path_for(resource_or_scope)
    if resource_or_scope.kind_of?(User)
      new_account_survey_path
    else #Admins [for future]
      super(resource_or_scope)
    end
  end
  
  def layout_by_resource 
    if devise_controller? && resource_name == :admin 
      "admin" 
    else 
      "application" 
    end 
  end

end
