$(document).ready(function() {
  L.mapbox.accessToken = 'pk.eyJ1Ijoib3dlbmxhbWIiLCJhIjoiY2lleWljcnF4MDBiOXQ0bHR0anRvamtucSJ9.t3YnHHqvQZ8Y0MTCNy0NNw';
  var map = L.mapbox.map('map')
       .setView([51.5072, -0.1], 9);
       L.control.locate().addTo(map);

  var myLayer = L.mapbox.featureLayer().addTo(map);
  var filters = document.getElementById('filters');
  var checkboxes = document.getElementsByClassName('filter');

  var layers = {
    Streets: L.mapbox.tileLayer('mapbox.streets'),
    ARRR: L.mapbox.tileLayer('mapbox.pirates'),
    Hipster: L.mapbox.tileLayer('mapbox.comic')
  };

  layers.Streets.addTo(map);
  layerControl = L.control.layers(layers, null, {position: 'topleft'});
  layerControl.addTo(map);
  // L.control.layers(layers).addTo(map);

  myLayer.on('layeradd', function(e) {
    var marker, popupContent, properties;
    marker = e.layer;
    properties = marker.feature.properties;
    popupContent =  '<div class="popup"><h3><a href="/activities/' + properties.id + '" target="marker">' + properties.name+ '</a></h3>' +
                   '<p><strong>When Its On:   </strong>' + properties.date + " " + properties.time + '</p>' +
                   '<p><strong>Location:   </strong>' + properties.address + '</p>' +
                   '<p><strong>People Needed: </strong>' + properties.participants + '</p>' +
                   '<p><strong>People In:  </strong>' + properties.active_participants+ '</p>' +
                 '</div>'
    return marker.bindPopup(popupContent, {
      closeButton: false,
      minWidth: 250
    });
  });

  function change() {
    var on = [];
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) on.push(checkboxes[i].value);
    }
    // The filter function takes a GeoJSON feature object
    // and returns true to show it or false to hide it.
    myLayer.setFilter(function (f) {
        // check each marker's symbol to see if its value is in the list
        // of symbols that should be on, stored in the 'on' array
        return on.indexOf(f.properties.category) !== -1;
    });
    return false;
  }

  // When the form is touched, re-filter markers
  filters.onchange = change;
  // Initially filter the markers
  change();

  myLayer.on('click', function(e) {
    map.panTo(e.layer.getLatLng());
  });

  $.ajax({
    dataType: 'text',
    url: '/locations.json',
    success: function(data) {
      var geojson;
      geojson = $.parseJSON(data);
      return myLayer.setGeoJSON(geojson);
    }
  });
});
