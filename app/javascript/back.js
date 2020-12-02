//戻るボタンでモーダル画面を閉じる関数
export const close = () => {
  $("#return").on("click",()=>{
    $("#back").html("");
    $("#back").hide();
  });
};

//モーダル画面を表示する関数
export const display = (html) => {
  $("#back").html(html);
  $("#back").fadeIn(200);
};