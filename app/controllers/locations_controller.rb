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
          date: activity.datetime.strftime('%d-%m-%y'),
          time: activity.datetime.strftime('%H:%M'),
          :'marker-color' => '#00607d',
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
