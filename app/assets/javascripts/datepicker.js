$(document).on('page:change', function(){
  $('.form_datetime').datepicker({
    format: "yyyy-mm-dd",
    todayBtn: "linked",
    clearBtn: true,
    orientation: "bottom left",
    autoclose: true,
    todayHighlight: true
  });
});
