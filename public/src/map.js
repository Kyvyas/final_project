L.mapbox.accessToken = 'pk.eyJ1Ijoib3dlbmxhbWIiLCJhIjoiY2lleWljcnF4MDBiOXQ0bHR0anRvamtucSJ9.t3YnHHqvQZ8Y0MTCNy0NNw';
var map = L.mapbox.map('map', 'mapbox.pirates')
    .setView([51.5072, -0.1], 9);
$.ajax({
  dataType: 'text',
  url: '/activity/map.json',
  success: function(data) {
    console.log(data);
    var geojson;
    geojson = $.parseJSON(data);
    return map.featureLayer.setGeoJSON(geojson);
  }
});
