class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all
  end

  def new
    @user = current_user
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.create(activity_params)
    flash[:notice] = "Your activity has been posted! Good luck!"
    redirect_to '/'
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :location, :participants, :date, :time, :category, :tag)
  end
end
