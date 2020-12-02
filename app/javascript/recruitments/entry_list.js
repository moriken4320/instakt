import {close, display} from "../back";
import {flash_create} from "../flash";
import {escapeStr} from "../escape";


const entry_list = ()=>{
  $(".entry-count").on("click",(e)=>{
    const recruit_id = e.currentTarget.getAttribute("data-recruit-id");
    ajax(`/recruitments/${recruit_id}/entries`);
  });
};

const html = (users)=>{
  let html = '<div class="entries-container center"><div class="entries-list">';
  users.forEach((user) => {
    html += `
      <div class="entry-wrap">
        <img src="${user.image}" class="entry-user-image">
        <p class="entry-user-name">${escapeStr(user.info.name)}<span>ID:${user.info.id}</span></p>
      </div>
    `;
  });
  html += '</div><div class="btn return-btn" id="return">戻る</div></div>';
  return html;
};

const ajax = (url)=>{
  $.ajax({
    url: url,
    type: "get",
    dataType: "json"
  })
  .done((data)=>{
    console.log(data.users);
    if(data.users.length <= 0){
      flash_create(data.flash.type, data.flash.message);
      return;
    }
    display(html(data.users));
    close();
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

$(function(){
  entry_list();
});