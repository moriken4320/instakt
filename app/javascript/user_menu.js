$(function () {
  $(document).on("click", "#user-icon", function(){
    $("#user-menu").fadeIn(100);
  });

  $(document).on('click',function(e) {
    if(!$(e.target).closest("#user-icon").length) {
      $("#user-menu").fadeOut(100);
    }
  });
});