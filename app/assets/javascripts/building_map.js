$(document).ready(function(){

  //initializes map
  var map = L.map('map', {
    center: [44.563781, -123.279444],
    zoom: 16
  });


  //set custom path to marker icons
  L.Icon.Default.imagePath = 'app/assets/images/marker-icon.png';

  //add map to window
  window.map = map;

  //set up which map service is used and set zoom params
  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
    maxZoom: 18
  }).addTo(map);

  //add marker to map
  var marker = new L.marker([44.563781, -123.279444], {
    draggable: true
  }).addTo(map);

  marker.on('click', injectCoords);

});

function injectCoords(e){
  console.log(e.latlng)
  $('#building_lat').val(e.latlng.lat);
  $('#building_long').val(e.latlng.lng);
}