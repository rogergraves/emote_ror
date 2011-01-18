class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:public_scorecard]
end
