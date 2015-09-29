$(document).ready(function() {
  L.mapbox.accessToken = 'pk.eyJ1Ijoib3dlbmxhbWIiLCJhIjoiY2lleWljcnF4MDBiOXQ0bHR0anRvamtucSJ9.t3YnHHqvQZ8Y0MTCNy0NNw';
  var postcode = $('#activity_location').val();
  $.getJSON("https://api.mapbox.com/v4/geocode/mapbox.places/"+postcode+".json?access_token=pk.eyJ1Ijoib3dlbmxhbWIiLCJhIjoiY2lleWljcnF4MDBiOXQ0bHR0anRvamtucSJ9.t3YnHHqvQZ8Y0MTCNy0NNw",function(result){
    var result = result.features[0].center
    var confirm_map = L.mapbox.map('confirm_map', 'mapbox.streets')
         .setView([result[1], result[0]], 15);

         var marker = L.marker([result[1], result[0]], {
             icon: L.mapbox.marker.icon({
               'marker-color': '#f86767'
             }),
             draggable: true
         }).addTo(confirm_map);
         marker.on('dragend', ondragend);


         ondragend();

         function ondragend() {
           var m = marker.getLatLng();
           var lat = m.lat
           var lng = m.lng
           console.log(lat,lng)
           $("#activity_latitude").val(lat);
           $("#activity_longitude").val(lng);

           $.getJSON("https://api.mapbox.com/v4/geocode/mapbox.places/"+lng+","+lat+".json?access_token=pk.eyJ1Ijoib3dlbmxhbWIiLCJhIjoiY2lleWljcnF4MDBiOXQ0bHR0anRvamtucSJ9.t3YnHHqvQZ8Y0MTCNy0NNw",function(dataResult){
             var address = dataResult.features[0].place_name;
             $("#activity_location").val(address);

           });


         }
        var coordinates = document.getElementById('coordinates');

    });
});
