class LocationsController < ApplicationController
  def index
    @activities = Activity.where(['datetime >= ?', DateTime.now])
    @geojson = Array.new

    @activities.each do |activity|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [activity.longitude, activity.latitude]
        },
        properties: {
          id: activity.id,
          name: activity.title,
          address: activity.location,
          description: activity.description,
          participants: (activity.participants - activity.active_participants),
          active_participants: activity.active_participants,
          date: activity.datetime.strftime("%a %d %b, %Y - at %I:%M %p"),
          category: activity.category,
          :'marker-color' => '#FE5F55',
          :'marker-symbol' => 'circle',
          :'marker-size' => 'medium'
          }
        }
    end
    respond_to do |format|
      format.html
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end
end
