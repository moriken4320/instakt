import {flash_create} from "../flash";

//募集終了ラベル表示非表示関数(募集一覧画面)
export const close_label = (close_flag)=>{
  $("#current_user_recruit").find(".close-label").remove();
  if(close_flag){
    $("#current_user_recruit").prepend($("<div>").addClass("close-label").text("募集が終了しました"));
    $("#close").attr("data-status", "restart").text("募集再開");
  }
  else{
    $("#close").attr("data-status", "close").text("募集終了");
  }
};

//ヘッダーに募集終了の有無を表示する関数(ルーム画面)
const header_close_check_text = (close_flag)=>{
  console.log(close_flag);
};

const ajax = (url, action)=>{
  $.ajax({
    url: url,
    type: "post",
    dataType: "json"
  })
  .done((data)=>{
    action(data.close_flag);
    flash_create(data.flash.type, data.flash.message);
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

const close_restart = ()=>{

  //募集一覧画面
  $("#close").on("click",()=>{
    ajax(`recruitments/${$("#close").attr("data-status")}`, close_label);
  });

  //ルーム画面のヘッダー
  $("#header-close").on("click",()=>{
    ajax($("#header-close").attr("data-status"), header_close_check_text);
  });
};

$(function(){
  close_restart();
});