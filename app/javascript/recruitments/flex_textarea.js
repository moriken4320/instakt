$(function(){
  $(".chat-area").on("input", ()=>{
    $(".flex-area-dummy").text($(".chat-area").val() + '\u200b');
  });
});