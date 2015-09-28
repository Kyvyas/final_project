class RatingsController < ApplicationController
  def new
    @activity = Activity.find(params[:activity_id])
    @rating = Rating.new
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @rating = @activity.build_rating(rating_params, current_user)
    unless @rating.save
      flash[:notice] = @rating.errors.full_messages
    end
      redirect_to activity_path(@activity)
  end

  def rating_params
    params.require(:rating).permit(:value)
  end
end