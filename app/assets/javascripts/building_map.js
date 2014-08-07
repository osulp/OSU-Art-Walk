$(document).ready(function(){
  var map = L.map('map', {
    center: [44.563781, -123.279444],
    zoom: 16
  });

  window.map = map

  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
    maxZoom: 18
  }).addTo(map);

  var marker = new L.marker([44.563781, -123.279444]).addTo(map);
});