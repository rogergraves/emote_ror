class Admin::BaseController < ApplicationController
  skip_before_filter :geocode_by_ip
  before_filter :authenticate_admin!
  layout 'admin'
  
  def index; end
end
