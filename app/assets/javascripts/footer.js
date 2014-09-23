$(window).load(resizeMain);
function resizeMain() {
  var windowHeight = window.innerHeight;
  var headerHeight = $("#header-navbar").outerHeight(true);
  var searchHeight = $("#search-navbarr").outerHeight(true);
  var contentHeight = $("#main-container").outerHeight(true);
  var footerHeight = $("#dynamicFooter").outerHeight(true);
  var mainHeight = headerHeight + searchHeight + contentHeight
  if (mainHeight < windowHeight){
    $("#main-container").css("min-height", windowHeight - searchHeight - headerHeight - footerHeight - 51);
    $("#dynamicFooter").css("visibility", "visible");
  }else{
    $("#dynamicFooter").css("visibility", "visible");
  }
}
