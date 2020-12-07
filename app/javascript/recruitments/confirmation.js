import {escapeStr} from "../escape";

const ajax = (url, html_display)=>{
  $.ajax({
    url: url,
    type: "get",
    dataType: "json",
  })
  .done((data)=>{
    html_display(data);
    $("#recruits-confirmation").slideDown(200);
    $("#chat-main").css("padding-top", $("#recruits-confirmation").height());
    close_confirmation();
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

const close_confirmation = () => {
  $("#confirmation").on("click",()=>{
    $("#recruits-confirmation").hide();
    $("#recruits-confirmation").html("");
    $("#chat-main").css("padding-top", 0);
  });
};

const later_html = (data)=>{
  const html = `
  <div class="recruit-wrap" id="confirmation">
    <div class="recruit-detail">
      <img src="${data.user.image}" class= "recruit-user-image" %>
      
      <div class="recruit-info">
        <div class="info-top">
          <div class="recruit-user-name">${escapeStr(data.user.info.name)}<span>ID: ${data.user.info.id}</span></div>
          <div class="recruit-type later">これから</div>
        </div>
        <ul class="info-bottom">
          <li>
            <div class="recruit-item">希望開始時間</div>
            <div class="recruit-value">${data.info.later.start_at_hour_top}:${data.info.later.start_at_minute_top} ~ ${data.info.later.start_at_hour_bottom}:${data.info.later.start_at_minute_bottom}</div>
          </li>
          <li>
            <div class="recruit-item">希望終了時間</div>
            <div class="recruit-value">${data.info.later.end_at_hour_top}:${data.info.later.end_at_minute_top} ~ ${data.info.later.end_at_hour_bottom}:${data.info.later.end_at_minute_bottom}</div>
          </li>
          <li>
            <div class="recruit-item">希望場所</div>
            <div class="recruit-value">${escapeStr(data.info.later.place)}</div>
          </li>
          <li>
            <div class="recruit-item">ひとこと</div>
            <div class="recruit-value">${escapeStr(data.info.later.message)}</div>
          </li>
        </ul>
      </div>
    </div>
  </div>
  `;
  $("#recruits-confirmation").html(html);
};

const now_html = (data)=>{
  const html = `
  <div class="recruit-wrap" id="confirmation">
    <div class="recruit-detail">
      <img src="${data.user.image}" class= "recruit-user-image" %>
        <div class="recruit-info">
          <div class="info-top">
            <div class="recruit-user-name">${escapeStr(data.user.info.name)}<span>ID: ${data.user.info.id}</span></div>
            <div class="recruit-type now">いま</div>
          </div>
          <ul class="info-bottom">
            <li>
              <div class="recruit-item">現在の人数</div>
              <div class="recruit-value">${data.info.now.member_count}人</div>
            </li>
            <li>
              <div class="recruit-item">終了予定時間</div>
              <div class="recruit-value">${data.info.now.end_at_hour_top}:${data.info.now.end_at_minute_top} ~ ${data.info.now.end_at_hour_bottom}:${data.info.now.end_at_minute_bottom}</div>
            </li>
            <li>
              <div class="recruit-item">現在の場所</div>
              <div class="recruit-value">${escapeStr(data.info.now.place)}</div>
            </li>
            <li>
              <div class="recruit-item">ひとこと</div>
              <div class="recruit-value">${escapeStr(data.info.now.message)}</div>
            </li>
          </ul>
        </div>
    </div>
</div>
  `;
  $("#recruits-confirmation").html(html);
};


$(function(){
  //募集が「これから」の場合
  $("#confirmation-later").on("click",()=>{
    ajax(`/recruitments/${$("#recruits-confirmation").attr("data-recruit-id")}/confirmation_later`, later_html);
  });
  
  //募集が「いま」の場合
  $("#confirmation-now").on("click",()=>{
    ajax(`/recruitments/${$("#recruits-confirmation").attr("data-recruit-id")}/confirmation_now`, now_html);
  });
});