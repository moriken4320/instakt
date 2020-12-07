
$(function(){
  const initial_height = $(".chat-bar").height();
  const flex_chat_bar = ()=>{
    $("#chat-main").css("padding-bottom", $(".chat-bar").height() - initial_height);
  };

  $(".chat-area").on("input", ()=>{
    $(".flex-area-dummy").text($(".chat-area").val() + '\u200b');
    flex_chat_bar();
  });
});