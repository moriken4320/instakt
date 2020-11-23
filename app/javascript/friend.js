$(function () {
  //リストをリセットする関数
  const reset_list = ()=>{
    $("#list-wrap").html("");
  };

  //フレンド一覧選択した際の関数
  const list = ()=>{
    $.ajax({
      url: "/friends/mutual",
      type: "get",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done((data)=>{
      data.forEach((d)=>{
        $("#list-wrap").html("a");
        console.log(d);
      });
    })
    .fail(()=>{
      alert("エラーが発生しました。");
    })
    .always(()=>{
    });
  };
  
  //申請中を選択した際の関数
  const applying = ()=>{
    console.log("申請中");
  };
  
  //承認待ちを選択した際の関数
  const approval_pending = ()=>{
    console.log("回答待ち");
  };
  
  //ユーザー検索を選択した際の関数
  const user_search = ()=>{
    console.log("ユーザー検索");
  };

  //上記の関数を格納
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