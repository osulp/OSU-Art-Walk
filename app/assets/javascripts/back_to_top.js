$(function(){
  $('.scroll-top-wrapper').on('click', scrollToTop);
});
function scrollToTop(){
  offsetTop = $('body').offset().top;
  $('html body').animate({scrollTop: offsetTop}, 500, 'linear');
}