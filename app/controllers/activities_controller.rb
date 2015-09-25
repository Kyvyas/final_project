class ActivitiesController < ApplicationController

  def index
    params["Category"] ? @activities = Activity.where(category: params["Category"]) : @activities = Activity.order(date: :asc)
    @categories = Category.all
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
      flash[:notice] = @activity.errors.full_messages.to_sentence
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
