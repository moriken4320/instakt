$(function(){
  const initial_height = $(".chat-bar").height();
  $(".chat-area").on("input", ()=>{
    $(".flex-area-dummy").text($(".chat-area").val() + '\u200b');
    $("#chat-main").css("padding-bottom", $(".chat-bar").height() - initial_height);
  });
});