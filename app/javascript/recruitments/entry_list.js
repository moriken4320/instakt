import {close, display} from "../back";

const entry_list = ()=>{
  $(".entry-count").on("click",(e)=>{
    const recruit_id = e.currentTarget.getAttribute("data-recruit-id");
    ajax(`/recruitments/${recruit_id}/entries`);
  });
};

const ajax = (url)=>{
  $.ajax({
    url: url,
    type: "get",
    dataType: "json"
  })
  .done((data)=>{
    console.log(data);
    // close_label(data.close_flag);
    // flash_create(data.flash.type, data.flash.message);
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

$(function(){
  entry_list();
});