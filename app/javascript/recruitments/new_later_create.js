import {escapeStr} from "../escape";

const later_create = () => {
  $("#later_create").on("submit",(e)=>{
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
      console.log(data);
      const recruits_container = $(".recruits-container");
      const recruit_wrap = $("<div>").addClass("recruit-wrap");
      let html = `
      <div class="recruit-detail">
        <img class="recruit-user-image" src="${data.user_image}">
        <div class="recruit-info">
          <div class="info-top">
            <div class="recruit-user-name">${escapeStr(data.recruit_later.later.user.name)}<span>ID: ${data.recruit_later.later.user.id}</span></div>
            <div class="recruit-type later">これから</div>
            <div class="post-time">投稿時間 ${data.recruit_later.recruit.created_at.substr(11, 5)}</div> 
          </div>
          <ul class="info-bottom">
            <li>
              <div class="recruit-item">希望開始時間</div>
              <div class="recruit-value">00:00 ~ 00:00</div>
            </li>
            <li>
              <div class="recruit-item">希望終了時間</div>
              <div class="recruit-value">00:00 ~ 00:00</div>
            </li>
            <li>
              <div class="recruit-item">希望場所</div>
              <div class="recruit-value"></div>
            </li>
            <li>
              <div class="recruit-item">ひとこと</div>
              <div class="recruit-value"></div>
            </li>
          </ul>
        </div>
        <div class="menu-btn-wrap">
          <i id="menu-btn" class="fas fa-ellipsis-v menu-btn"></i>
          <div id="recruit-menu-content" class="recruit-menu-content">
            <a href="#">編集</a>
            <a href="#">飲募終了</a>
          </div>
        </div>
      </div>
      <div class="entry-wrap">
        <i class="fas fa-user-circle entry-count"><span>0/10</span></i>
        <div class="btn entry-btn">参加</div>
      </div>
      `;
      $("#back").html("").hide();
      $("html,body").animate({scrollTop: 0}, 500);
      recruit_wrap.html(html);
      recruits_container.prepend(recruit_wrap).fadeIn(200);
    })
    .fail(()=>{
      alert("エラーが発生しました。");
    })
    .always(()=>{
    });
  });
};

export {later_create};