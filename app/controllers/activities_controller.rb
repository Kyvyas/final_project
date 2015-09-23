class ActivitiesController < ApplicationController

  def index
    @activities = Activity.order(date: :asc)
  end

  def new
    @user = current_user
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.new(activity_params)
    if @activity.save
      flash[:notice] = "Your activity has been posted! Good luck!"
    else
      flash[:notice] = "Please select a valid number of participants"
    end
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
