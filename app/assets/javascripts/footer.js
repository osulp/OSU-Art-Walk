$(function(){
  $(window).load(resizeFooter);
  $(window).resize(resizeFooter);
});
function resizeFooter() {
  var windowHeight = window.innerHeight;
  var headerHeight = $("#header-navbar").height();
  var searchHeight = $("#search-navbarr").height();
  var contentHeight = $("#main-container").height();
  var footerHeight = $("#dynamicFooter").height();
  var mainHeight = headerHeight + searchHeight + contentHeight
  if (mainHeight < windowHeight){
    $("#main-container").css("min-height", windowHeight - 200);
  }
}
