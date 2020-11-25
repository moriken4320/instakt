import {flash_create} from "../flash";
import {heart} from "./friend_good";
import {escapeStr} from "../escape";

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

  //検索フォームにフォーカスした際、css適用
  $("#search-input").on("focus",(e)=>{
    $(e.target).addClass("focus");
  });

  //検索フォームにフォーカスを外した際、css削除
  $("#search-input").on("blur",(e)=>{
    $(e.target).removeClass("focus");
  });

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
      flash_create("danger", "半角数値を入力してください");
      return;
    }
    $.ajax({
      url: url,
      type: "get",
      data: {keyword: keyword},
      dataType: "json"
    })
    .done((data)=>{
      console.log(data[0].info);
      let html = "";
      if(data[0].info == null){
        html = `<p class="empty-message" style="font-size: 20px;">ユーザーID：${keyword}　に該当するユーザーが見つかりませんでした</p>`;
      }
      else{
        let heart_class = "fas fa-heart fa-3x";
        if(data[0].follower_flag){
          heart_class += " good"
        }
        html = `<div class="list-user-content">
        <img id ="list-${data[0].info.id}-image" class="list-user-image" src="${data[0].image}" style="width: 75px; height: 75px; object-fit: cover;">
        <div class="list-user-name">
          ${escapeStr(data[0].info.name)}<span>ID:${data[0].info.id}</span>
        </div>
        <div class="list-user-heart">
            <i class="${heart_class}" data-id="${data[0].info.id}"></i>
        </div>
        </div>`;
      }
      $("#list-wrap").html(html);
      heart();
    })
    .fail(()=>{
      alert("エラーが発生しました。");
    })
    .always(()=>{
      $("#search-input").trigger("blur");
    });
  });

});
