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
   #   flash[:notice] = "Please select a valid number of participants"
    end
    redirect_to '/'
  end

  def show
    @activity = Activity.find(params[:id])
    @people_needed = @activity.participants - @activity.active_participants
  end

  def location
    p "running method LOCATION"
    @activities = Activity.all
    @geojson = Array.new

    @activities.each do |activity|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [activity.longitude, activity.latitude]
        },
        properties: {
          name: activity.title,
          address: activity.location,
          :'marker-color' => '#00607d',
          :'marker-symbol' => 'circle',
          :'marker-size' => 'medium'
          }
        }
        p @geojson
    end
    respond_to do |format|
      format.html
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end
  #
  # def loc_param
  #
  # end


  def activity_params
    params.require(:activity).permit(:title, :description, :location, :participants, :date, :time, :category, :tag)
  end

  def filter
    # redirect_to ("/activity/#{params[]}")
  end
end
