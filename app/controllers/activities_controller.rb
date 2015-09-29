class ActivitiesController < ApplicationController

  def index
    @tag = params["Tag"]
    if @tag
      @activities = Activity.where(tag: @tag.downcase)

    elsif params["Category"]
      @activities = Activity.where(category: params["Category"])
    else
      # @activities = Activity.where(['date >= ?', DateTime.now]).where(['time >= ?', ("2000-01-01 #{Time.now.strftime('%H:%M:%S')}")]).order(date: :asc)
      # @activities = Activity.order(date: :asc)
      # @activities = Activity.where(['datetime >= ?', Time.now.to_formatted_s(:db)]).order(datetime: :asc)
      @activities = Activity.where(['datetime >= ?', DateTime.now]).order(datetime: :asc)


    end
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
      ConfirmationMailer.confirm_activity(@activity, current_user).deliver_now
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
    params.require(:activity).permit(:title, :description, :location, :participants, :datetime, :category, :tag)
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to user_path(current_user)
  end
end
