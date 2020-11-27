$(function () {
  $(document).on("click", "#menu-btn", function(){
    $("#recruit-menu-content").fadeIn(100);
  });

  $(document).on('click',function(e) {
    if(!$(e.target).closest("#menu-btn").length) {
      $("#recruit-menu-content").fadeOut(100);
    }
  });
});