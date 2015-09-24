class RatingsController < ApplicationController
  def new
    @activity = Activity.find(params[:activity_id])
    @rating = Rating.new
  end

  def create
    p params
    @activity = Activity.find(params[:activity_id])
    @rating = @activity.build_rating(rating_params, current_user)
    @rating.save
    p "=========this one"
    p @activity.ratings.any?
    redirect_to activity_path(@activity)
  end

  def rating_params
    params.require(:rating).permit(:value)
  end

end
