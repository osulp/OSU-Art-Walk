function remove_fields(link){
  $(link).prev('input[type=hidden]').val("1");
  $(link).closest('.fields').hide();
}

$(document).ready(function(){
  $('form').on('click', '.add_fields', function (event){
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  });
});