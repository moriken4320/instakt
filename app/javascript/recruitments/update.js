import {flash_create} from "../flash";
import {close_label} from "./close_restart";

//募集更新用ajax関数
const update_ajax = (url, form_data, override)=>{
  $.ajax({
    url: url,
    type: "post",
    data: form_data,
    dataType: "json",
    processData: false,
    contentType: false
  })
  .done((data)=>{
    override(data);
    flash_create(data.flash.type, data.flash.message);
    $("#back").html("");
    $("#back").fadeOut(200);
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};


//「これから」の募集を上書きする関数
const later_override = (data)=>{
  close_label(data.recruit_later.close);
  $("#current_user_recruit, #confirmation").find(".recruit-value:first").text(`${data.recruit_later.later.start_at_hour_top}:${data.recruit_later.later.start_at_minute_top} ~ ${data.recruit_later.later.start_at_hour_bottom}:${data.recruit_later.later.start_at_minute_bottom}`);
  $("#current_user_recruit, #confirmation").find(".recruit-value:eq(1)").text(`${data.recruit_later.later.end_at_hour_top}:${data.recruit_later.later.end_at_minute_top} ~ ${data.recruit_later.later.end_at_hour_bottom}:${data.recruit_later.later.end_at_minute_bottom}`);
  $("#current_user_recruit, #confirmation").find(".recruit-value:eq(2)").text(data.recruit_later.later.place);
  $("#current_user_recruit, #confirmation").find(".recruit-value:last").text(data.recruit_later.later.message);
  $("#current_user_recruit, #confirmation").find("#recruit-count").text(data.recruit_later.recruit.close_condition_count);
  $("#header-recruit-count").text(data.recruit_later.recruit.close_condition_count);
};

//「いま」の募集を上書きする関数
const now_override = (data)=>{
  close_label(data.recruit_now.close);
  $("#current_user_recruit, #confirmation").find(".recruit-value:first").text(`${data.recruit_now.now.member_count}人`);
  $("#current_user_recruit, #confirmation").find(".recruit-value:eq(1)").text(`${data.recruit_now.now.end_at_hour_top}:${data.recruit_now.now.end_at_minute_top} ~ ${data.recruit_now.now.end_at_hour_bottom}:${data.recruit_now.now.end_at_minute_bottom}`);
  $("#current_user_recruit, #confirmation").find(".recruit-value:eq(2)").text(data.recruit_now.now.place);
  $("#current_user_recruit, #confirmation").find(".recruit-value:last").text(data.recruit_now.now.message);
  $("#current_user_recruit, #confirmation").find("#recruit-count").text(data.recruit_now.recruit.close_condition_count);
  $("#header-recruit-count").text(data.recruit_now.recruit.close_condition_count);
};

export const update = ()=>{

  //「これから」募集を更新する処理
  $("#later-update").on("submit",(e)=>{
    e.preventDefault();
    const form_data = new FormData(e.target);
    const url = $(e.target).attr("action");
    update_ajax(url, form_data, later_override);
  });

  //「いま」募集を更新する処理
  $("#now-update").on("submit",(e)=>{
    e.preventDefault();
    const form_data = new FormData(e.target);
    const url = $(e.target).attr("action");
    update_ajax(url, form_data, now_override);
  });
};