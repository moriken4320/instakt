//募集終了ラベル表示非表示関数
export const finish_label = (close_flag)=>{
  $("#current_user_recruit").find(".finish-label").remove();
  if(close_flag){
    $("#current_user_recruit").prepend($("<div>").addClass("finish-label").text("募集が終了しました"));
    $("#close").attr("data-status", "restart").text("募集再開");
  }
  else{
    $("#close").attr("data-status", "finish").text("募集終了");
  }
};

const ajax = (url)=>{
  $.ajax({
    url: url,
    type: "post",
    dataType: "json"
  })
  .done((data)=>{
    console.log(data);
    finish_label(data);
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

const close_restart = ()=>{
  $("#close").on("click",()=>{
    ajax(`recruitments/${$("#close").attr("data-status")}`);
  });
};

$(function(){
  close_restart();
});