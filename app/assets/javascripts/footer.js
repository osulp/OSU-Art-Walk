$(function(){
  $(window).load(resizeFooter);
  $(window).resize(resizeFooter);
});
// Dynamically resize footer to fill page, IE8 doesn't like this.
function resizeFooter() {
  var windowHeight = window.innerHeight;
  var headerHeight = $("#header-navbar").height();
  var searchHeight = $("#search-navbarr").height();
  var contentHeight = $("#main-container").height();
  var footerHeight = $("#dynamicFooter").height();
  // 107 references a negative margin in header - you'll need to account for this if necessary
  var flexFooter = windowHeight - (headerHeight + contentHeight + searchHeight + footerHeight - 218);

  //var newFooter = (flexFooter > 290) ? 290 : flexFooter
  $("#dynamicFooter").css("min-height", flexFooter);
}
