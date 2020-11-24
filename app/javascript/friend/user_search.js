import {flash_create} from "../flash";

$(function(){

  //検索ボタンをアクティブにする関数
  const form_active = () => {
    $("#search-btn").addClass("active");
    $("#search-btn").prop("disabled", false);
  };
  
  //検索ボタンを非アクティブにする関数
  const form_disable = () => {
    $("#search-btn").removeClass("active");
    $("#search-btn").prop("disabled", true);
  };

  //検索ボタン実行可否チェック
  $("#search-input").on("keyup",(key)=>{
    const blank_check = ($("#search-input").val() == "")

    if(!blank_check){
      form_active();
    }
    else{
      form_disable();
    }
  });

  //検索が実行された際の処理
  $("#search-form").on("submit",(e)=>{
    e.preventDefault();
    
    const url = $(e.target).attr("action");
    const keyword = $("#search-input").val();
    if(!isFinite(keyword)){
      flash_create("danger", "数値を入力してください");
      return;
    }
    $.ajax({
      url: url,
      type: "get",
      data: {keyword: keyword},
      dataType: "json"
    })
    .done((data)=>{
      console.log(data);
    })
    .fail(()=>{
      alert("エラーが発生しました。");
    })
    .always(()=>{
      $("#search-input").trigger("blur");
    });
  });

});
