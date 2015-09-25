class LocationsController < ApplicationController
  def index
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
          id: activity.id,
          name: activity.title,
          address: activity.location,
          description: activity.description,
          participants: (activity.participants - activity.active_participants),
          active_participants: activity.active_participants,
          date: Date.parse(activity.date.to_s).strftime('%d-%m-%y'),
          time: activity.time.strftime('%H:%M'),
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
