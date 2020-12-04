import {flash_create} from "../flash";

//募集終了ラベル表示非表示関数(募集一覧画面)
export const close_label = (close_flag)=>{
  $("#current_user_recruit").find(".close-label").remove();
  if(close_flag){
    $("#current_user_recruit").prepend($("<div>").addClass("close-label").text("募集が終了しました"));
    $("#close").attr("data-status", "restart").text("募集再開");

    //ルーム画面のヘッダー
    if($("#page_name").text() == "マイ募集ルーム(募集中)"){
      $("#page_name").text("マイ募集ルーム(募集終了)");
    }
  }
  else{
    $("#close").attr("data-status", "close").text("募集終了");

    //ルーム画面のヘッダー
    if($("#page_name").text() == "マイ募集ルーム(募集終了)"){
      $("#page_name").text("マイ募集ルーム(募集中)");
    }
  }
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

  $("#close").on("click",()=>{
    ajax(`/recruitments/${$("#close").attr("data-status")}`, close_label);
  });
};

$(function(){
  close_restart();
});