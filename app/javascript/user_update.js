import {flash_create} from "./flash";

$(function () {
  let current_name = $("#user-name").val();
  let current_email = $("#user-email").val();
  let image_chage = false;

  //更新ボタンをアクティブにする関数
  const form_active = () => {
    $("#actions").attr("for", "form-btn");
    $("#form-btn").prop("disabled", false);
  };
  
  //更新ボタンを非アクティブにする関数
  const form_disable = () => {
    $("#actions").removeAttr("for");
    $("#form-btn").prop("disabled", true);
  };

  // //flashオブジェクト作成関数
  // const flash_create = (type, text) => {
  //   const flash = $("<div>").addClass(`common ${type}`).text(text);
  //   $("header").append(flash);
  //   flash.slideDown(500);
  //   setTimeout(()=>{
  //     $(flash).slideUp(500, ()=>{
  //       $(flash).remove();
  //     });
  //   }, 2000);
  // };

  //画像変更時、プロフィールの画像も即時に変更
  $("#image-field").on("change",(e)=>{
    const blob = window.URL.createObjectURL(e.target.files[0]);
    $("#user-image").attr("src", blob).css({"width": "150px", "height": "150px", "object-fit": "cover"});
    image_chage = true;
    form_active();
  });

  //input要素に対して、フォーカスしたかの有無でcss適用
  const input_elements = ["name", "email"];
  input_elements.forEach((element)=>{
    //フォーカスした際
    $(`#user-${element}`).on("focus",(e)=>{
      $(`#${element}-label`).addClass("label-active");
      $(e.target).addClass("input-active");
    });

    //フォーカスを外した際
    $(`#user-${element}`).on("blur",(e)=>{
      $(`#${element}-label`).removeClass("label-active");
      $(e.target).removeClass("input-active");
    });
  });

  //name,emailのフォームに差分があれば、更新ボタンをアクティブ化
  $("#user-name, #user-email").on("keyup", (key)=>{
    const difference_check = (current_name != $("#user-name").val() || current_email != $("#user-email").val() || image_chage);
    const blank_check = ($("#user-name").val() == "" || $("#user-email").val() == "")

    if(difference_check && !blank_check){
      if(key.originalEvent.key != "Enter"){
        form_active();
      }
    }
    else{
      form_disable();
    }
  });
  
  //更新ボタン実行時
  $("#user-form").on("submit",(e)=>{
    e.preventDefault();

    const form_data = new FormData(e.target);
    const url = $(e.target).attr("action");
    $.ajax({
      url: url,
      type: "post",
      data: form_data,
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done((data)=>{
      $("#user-icon").attr("src", $("#user-image").attr("src")).css({"width": "50px", "height": "50px", "object-fit": "cover"});
      current_name = data.user.name;
      current_email = data.user.email;
      image_chage = false;
      flash_create(data.flash.type, data.flash.message);
      form_disable();
    })
    .fail(()=>{
      alert("エラーが発生しました。");
    })
    .always(()=>{
    });
  });
});