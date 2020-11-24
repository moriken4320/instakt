import {heart} from "./friend_good";

$(function () {
  //特殊文字をエスケープする関数
  const escapeStr = (s)=>{
    s = s.replace(/&/g, "&amp;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/\n/g, "<br>");
  
    return s
  }

  //リストをリセットする関数
  const reset_list = ()=>{
    $("#list-wrap").html("");
  };

  //Ajaxの処理をまとめた関数
  const ajax_action = (path, empty_message)=>{
    $.ajax({
      url: `/friends/${path}`,
      type: "get",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done((data)=>{
      if(data.length <= 0){
        $("#list-wrap").html(`<p class="empty-message">${empty_message}</p>`);
        return;
      }
      
      let html = ``;
      data.forEach((d)=>{
        let heart_class = "fas fa-heart fa-3x";
        if(d.follower_flag){
          heart_class += " good"
        }
        html += `<div class="list-user-content">
        <img id ="list-${d.info.id}-image" class="list-user-image" src="${d.image}" style="width: 75px; height: 75px; object-fit: cover;">
        <div class="list-user-name">
          ${escapeStr(d.info.name)}<span>ID:${d.info.id}</span>
        </div>
        <div class="list-user-heart">
            <i class="${heart_class}" data-id="${d.info.id}"></i>
        </div>
        </div>`;
      });
      $("#list-wrap").html(html);
      heart();
    })
    .fail(()=>{
      alert("エラーが発生しました。");
    })
    .always(()=>{
    });
  };

  //フレンド一覧選択した際の関数
  const list = ()=>{
    ajax_action("mutual", "フレンドが存在しません<p class='guide'>※お互いにハートを付けることで、フレンドとして登録されます。</p>");
  };
  
  //申請中を選択した際の関数
  const applying = ()=>{
    ajax_action("oneway_followers", "現在、申請中のユーザーは存在しません");
  };
  
  //承認待ちを選択した際の関数
  const approval_pending = ()=>{
    ajax_action("oneway_followings", "現在、回答待ちのユーザーは存在しません");
  };
  
  //ユーザー検索を選択した際の関数
  const user_search = ()=>{
    console.log("ユーザー検索");
  };

  //各タブの関数を格納
  const display_list = [
    list, applying, approval_pending, user_search
  ];

  //各タブをクリックした際の処理
  $(".friend-tab").on("click",(e)=>{
    //現在のタブをクリックした時は早期リターン
    if($(`#${e.target.id}`).hasClass("select-tab")){
      return;
    }
    const tabs = $(".friend-tab-wrap").children();
    tabs.each((index, tab)=>{
      if(tab == e.target){
        $(`#${tab.id}`).addClass("select-tab");
        reset_list();
        display_list[index]();
      }else{
        $(`#${tab.id}`).removeClass("select-tab");
      }
    });
  });
});