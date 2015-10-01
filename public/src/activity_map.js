$(document).ready(function() {
  L.mapbox.accessToken = 'pk.eyJ1Ijoib3dlbmxhbWIiLCJhIjoiY2lleWljcnF4MDBiOXQ0bHR0anRvamtucSJ9.t3YnHHqvQZ8Y0MTCNy0NNw';
  var activity_map = L.mapbox.map('activity_map', 'mapbox.pirates')
  var myLayer = L.mapbox.featureLayer().addTo(activity_map);


  myLayer.on('layeradd', function(e) {
    var marker;
    marker = e.layer;
    lat = marker._latlng.lat;
    lon = marker._latlng.lng;
    activity_map.setView([lat, lon], 17);

  });

  var pathname = window.location.pathname;

  $.ajax({
    dataType: 'text',
    url: pathname+".json",
    success: function(data) {
      var geojson;
      geojson = $.parseJSON(data);
      return myLayer.setGeoJSON(geojson);
    }
  });
});
