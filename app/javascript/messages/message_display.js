
import {escapeStr} from "../escape";

//メッセージ表示用ajax関数
const update_ajax = (url, form_data, html_create)=>{
  $.ajax({
    url: url,
    type: "post",
    data: form_data,
    dataType: "json",
    processData: false,
    contentType: false
  })
  .done((data)=>{
    console.log(data);
    html_create(data);
    reset_form();
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    $("#send-btn").prop("disabled", false);
  });
};

//フォーム送信後のリセット関数
const reset_form = ()=>{
  $("#message_image").val(null);
  $("#image-wrap").remove();
  $(".chat-area").val("");
  $(".flex-area-dummy").text("");
  $("#chat-main").removeAttr("style");
  $("html, body").animate({ scrollTop: $(document).height() }, "slow");
};

//メッセージ要素作成関数
const message_element = (data)=>{
  if(data.message == null){
    return;
  }
  const my_chat_area = $("<div>").addClass("my-chat-area");

  const my_left_wrap = $("<div>").addClass("my-left-wrap");
  const my_chat_time = $("<div>").addClass("my-chat-time").text(data.message.info.created_at.substr(11, 5));
  my_left_wrap.append(my_chat_time);
  
  const my_right_wrap = $("<div>").addClass("my-right-wrap");
  const my_chat = $("<div>").addClass("my-chat chat").html(escapeStr(data.message.info.text));
  if(data.message.image != null){
    const image_element = $("<img>").addClass("attached-image").attr("src", data.message.image);
    my_chat.prepend(image_element);
  }
  my_right_wrap.append(my_chat);

  my_chat_area.append(my_left_wrap);
  my_chat_area.append(my_right_wrap);


  $("#chat-main").append(my_chat_area);
};

$(function(){
  $("#chat-bar").on("submit",(e)=>{
    e.preventDefault();
    const form_data = new FormData(e.target);
    const url = $(e.target).attr("action");
    update_ajax(url, form_data, message_element);
  });
});