class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all
  end

  def new
    @user = current_user
    @activity = Activity.new
  end
end
