$(function(){
  $('.scroll-top-wrapper').on('click', scrollToTop);
  $(".scroll-top-wrapper").mouseup(function(){
    $(this).blur();
  });
});
function scrollToTop(){
  offsetTop = $('body').offset().top;
  $('html body').animate({scrollTop: offsetTop}, 500, 'linear');
}