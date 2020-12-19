import {escapeStr} from "../escape";

//メッセージ表示用ajax関数
const ajax = (url, html_create)=>{
  const last_message_id = $(".chat-content:last").data("message-id");
  $.ajax({
    url: url,
    type: "get",
    data: {id: last_message_id},
    dataType: "json",
  })
  .done((all_data)=>{
    all_data.forEach((data)=>{
      html_create(data);
    });
  })
  .fail(()=>{
    location.reload();
  })
  .always(()=>{
  });
};

const html_create = (data) =>{
  if(data.length <= 0){
    return;
  }
  const other_chat_area = $("<div>").addClass("other-chat-area chat-content").attr("data-message-id", data.message.info.id);

  const other_left_wrap = $("<div>").addClass("other-left-wrap");
  const other_user_image = $("<img>").addClass("other-user-image").attr("src", data.user.image);
  other_left_wrap.append(other_user_image);

  const other_center_wrap = $("<div>").addClass("other-center-wrap");
  const other_user_name = $("<div>").addClass("other-user-name").html(`${escapeStr(data.user.info.name)}<span>ID:${data.user.info.id}</span>`);
  const other_chat = $("<div>").addClass("other-chat chat").html(escapeStr(data.message.info.text));
  if(data.message.image != null){
    const image_element = $("<img>").addClass("attached-image").attr("src", data.message.image);
    other_chat.prepend(image_element);
  }
  other_center_wrap.append(other_user_name);
  other_center_wrap.append(other_chat);

  const other_right_wrap = $("<div>").addClass("other-right-wrap");
  const other_chat_time = $("<div>").addClass("other-chat-time").text(data.message.info.created_at.substr(11, 5));
  other_right_wrap.append(other_chat_time);

  other_chat_area.append(other_left_wrap);
  other_chat_area.append(other_center_wrap);
  other_chat_area.append(other_right_wrap);


  $("#chat-main").append(other_chat_area);
};

$(function(){
  setInterval(function(){
    ajax(`/recruitments/${$("#recruits-confirmation").attr("data-recruit-id")}/messages/reload`, html_create);
  }, 5000);
});