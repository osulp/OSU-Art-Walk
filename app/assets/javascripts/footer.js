jQuery(resizeMain);
$(window).resize(resizeMain);
function resizeMain() {
  var windowHeight = $(window).height();
  var footerHeight = $("#dynamicFooter").outerHeight(true);
  var containerPos = $("#main-container").offset().top;
  $("#main-container").css("min-height", windowHeight-containerPos-footerHeight);
}
