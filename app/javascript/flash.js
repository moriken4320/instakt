function flash_anim(){
  $(".common").slideDown(500);
  setTimeout(()=>{
    $(".common").slideUp(500);
  }, 2000);
};

//flashオブジェクト作成関数
function flash_create(type, text){
  const flash = $("<div>").addClass(`common ${type}`).text(text);
  $("header").append(flash);
  flash.slideDown(500);
  setTimeout(()=>{
    $(flash).slideUp(500, ()=>{
      $(flash).remove();
    });
  }, 2000);
};

$(function () {
  flash_anim();
});

export {flash_create};