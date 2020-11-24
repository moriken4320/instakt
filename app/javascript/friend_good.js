import {flash_create} from "./flash";

function heart(){
  //ハートをクリックした際の処理
  $(".fa-heart").on("click",(e)=>{
    const follower_id = $(e.target).attr("data-id");
    
    $.ajax({
      url: `friends/${follower_id}/heart`,
      type: "post",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done((data)=>{
      if(data.heart == null){ //実行後→ハートが解除
        $(`i[data-id="${follower_id}"]`).removeClass("good");
      }
      else{ //実行後→ハートが付与
        $(`i[data-id="${follower_id}"]`).addClass("good");
      }
      flash_create(data.flash.type, data.flash.message);
    })
    .fail(()=>{
      alert("エラーが発生しました。");
    })
    .always(()=>{
    });
  });
};

$(function(){
  heart();
});

export {heart};