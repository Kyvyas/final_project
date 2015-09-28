$(document).ready(function() {
  L.mapbox.accessToken = 'pk.eyJ1Ijoib3dlbmxhbWIiLCJhIjoiY2lleWljcnF4MDBiOXQ0bHR0anRvamtucSJ9.t3YnHHqvQZ8Y0MTCNy0NNw';
  var confirm_map = L.mapbox.map('confirm_map', 'mapbox.streets')
       .setView([51.5072, -0.1], 9);

  var coordinates = document.getElementById('coordinates');

  var marker = L.marker([51.5072, -0.1], {
      icon: L.mapbox.marker.icon({
        'marker-color': '#f86767'
      }),
      draggable: true
  }).addTo(confirm_map);

  // every time the marker is dragged, update the coordinates container
  marker.on('dragend', ondragend);

  // Set the initial marker coordinate on load.
  ondragend();

  function ondragend() {
      var m = marker.getLatLng();
      coordinates.innerHTML = 'Latitude: ' + m.lat + '<br />Longitude: ' + m.lng;
      console.log(m.lat)
      console.log(m.lng)
  }

});