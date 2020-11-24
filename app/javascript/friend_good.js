$(function(){

  //ハートをクリックした際の処理
  $(".fa-heart").on("click",(e)=>{
    const follower_id = $(e.target).attr("data-id");
    const follower_flag = $(e.target).hasClass("good");

    if(follower_flag){

    }
    else{

    }

    console.log(follower_id);
    console.log(follower_flag);
  });
});