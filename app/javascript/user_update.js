$(function () {
  let current_name = $("#user-name").val();
  let current_email = $("#user-email").val();
  let image_chage = false;

  //更新ボタンをアクティブにする関数
  const form_active = () => {
    $("#actions").attr("for", "form-btn");
    $("#form-btn").prop("disabled", false);
  };

  //flashオブジェクト作成関数
  const flash_create = (type, text) => {
    const flash = $("<div>").addClass(`common ${type}`).text(text);
    $("header").append(flash);
    flash.slideDown(500);
    setTimeout(()=>{
      $(flash).slideUp(500, ()=>{
        $(flash).remove();
      });
    }, 2000);
  };

  //画像変更時、プロフィールの画像も即時に変更
  $("#image-field").on("change",(e)=>{
    const blob = window.URL.createObjectURL(e.target.files[0]);
    $("#user-image").attr("src", blob).css({"width": "150px", "height": "150px", "object-fit": "cover"});
    image_chage = true;
    form_active();
  });

  //nameがフォーカスされた際、input要素の色を変更
  $("#user-name").on("focus",(e)=>{
    $("#name-label").addClass("label-active");
    $(e.target).addClass("input-active");
  });
  //nameからフォーカスが外れた際、input要素の色を戻す
  $("#user-name").on("blur",(e)=>{
    $("#name-label").removeClass("label-active");
    $(e.target).removeClass("input-active");
  });

  //emailがフォーカスされた際、input要素の色を変更
  $("#user-email").on("focus",(e)=>{
    $("#email-label").addClass("label-active");
    $(e.target).addClass("input-active");
  });
  //emailからフォーカスが外れた際、input要素の色を戻す
  $("#user-email").on("blur",(e)=>{
    $("#email-label").removeClass("label-active");
    $(e.target).removeClass("input-active");
  });

  //name,emailのフォームに差分があれば、更新ボタンをアクティブ化
  $("#user-name, #user-email").on("keyup", (key)=>{
    if(current_name != $("#user-name").val() || current_email != $("#user-email").val() || image_chage){
      if(key.originalEvent.key != "Enter"){
        form_active();
      }
    }
    else{
      $("#actions").removeAttr("for");
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
      current_name = data.name;
      current_email = data.email;
      image_chage = false;
      flash_create("success", "更新しました");
      $("#actions").removeAttr("for");
      $("#user-name, #user-email").trigger("blur");
    })
    .fail(()=>{
      flash_create("danger", "更新に失敗しました");
    })
    .always(()=>{
      
    });
  });
});