$(document).ready(function(){
  $('.myMap').each(function(){
    var map = L.map('map', {
      center: [44.563781, -123.279444],
      zoom: 16
    });

    //set custom path to marker icon
    var markerIcon = new L.Icon({
      iconUrl: 'http://www.lscarolinas.net/assets/leaflet/images/marker-icon-blue.png',
      iconAnchor: [13, 12]
    });

    //add map to window
    window.map = map;

    //set up which map service is used and set zoom params
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
      maxZoom: 18
    }).addTo(map);

    //add marker to map

    var marker = new L.marker([44.563781, -123.279444], {
        draggable: true,
        icon: markerIcon
      }).addTo(map);

    if($('#building_lat').val() != 0){
      marker.setLatLng([$('#building_lat').val(), $('#building_long').val()]);
    }

    map.on('mouseup', function(e){marker.setLatLng(e.latlng)});
    map.on('mousedown', injectCoords);
  });
});


function injectCoords(e, marker){
  $('#building_lat').val(e.latlng.lat);
  $('#building_long').val(e.latlng.lng);
}
