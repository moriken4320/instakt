// タブレットサイズ(1100px以下)
const tablet_size = 1100;

// スマホサイズ(600px以下)
const smh_size = 600;

// ページがリサイズしたときに実行する関数
const resize = ()=>{
  if($(window).width() <= smh_size){
    $(".new-recruit-btn").text("＋");
    $(".recruit-room-btn").html('<i class="fas fa-comments"></i>');
  }else if($(window).width() <= tablet_size){
    $(".new-recruit-btn").text("募集する");
    $(".recruit-room-btn").text("マイ募集ルーム");
  }else{
    $(".new-recruit-btn").text("募集する");
    $(".recruit-room-btn").text("マイ募集ルーム");
  }
};

$(function(){
  resize();
  $(window).on("resize",()=>{
    resize();
  });
});