class ActivitiesController < ApplicationController

  def index
    @activities = Activity.order(date: :asc)
    p @activities
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

  def show
    @activity = Activity.find(params[:id])
    @people_needed = @activity.participants - @activity.active_participants
  end


  def activity_params
    params.require(:activity).permit(:title, :description, :location, :participants, :date, :time, :category, :tag)
  end
end
