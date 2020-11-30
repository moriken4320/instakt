import {flash_create} from "../flash";
import {escapeStr} from "../escape";

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
    console.log(data);
    override(data);
    flash_create(data.flash.type, data.flash.message);
    $("#back").html("");
    $("#back").hide();
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

//「これから」の募集を上書きする関数
const later_override = (data)=>{
  $("#current_user_recruit").find(".recruit-value:first").text(`${data.recruit_later.later.start_at_hour_top}:${data.recruit_later.later.start_at_minute_top} ~ ${data.recruit_later.later.start_at_hour_bottom}:${data.recruit_later.later.start_at_minute_bottom}`);
  $("#current_user_recruit").find(".recruit-value:eq(1)").text(`${data.recruit_later.later.end_at_hour_top}:${data.recruit_later.later.end_at_minute_top} ~ ${data.recruit_later.later.end_at_hour_bottom}:${data.recruit_later.later.end_at_minute_bottom}`);
  $("#current_user_recruit").find(".recruit-value:eq(2)").text(data.recruit_later.later.place);
  $("#current_user_recruit").find(".recruit-value:last").text(data.recruit_later.later.message);
};

//「いま」の募集を上書きする関数
const now_override = (data)=>{

};

export const update = ()=>{

  //「これから」募集を更新する処理
  $("#later-update-btn").on("click",()=>{
    const form_data = new FormData($("#later_update")[0]);
    const url = $($("#later_update")).attr("action");
    update_ajax(url, form_data, later_override);
  });
};