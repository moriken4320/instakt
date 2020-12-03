import {close, display} from "../back";

const popup_display = (url, message)=>{
  const html = `
  <div class="popup center">
    <p>${message}</p>
    <div class="btn-wrap">
      <div class="btn return-btn" id="return">いいえ</div>
      <a rel="nofollow" data-method="delete" href=${url} class="btn submit-btn">はい</a>
    </div>
  </div>
`;
  display(html);
  close();
};

$(function(){
  //募集削除をクリックした際
  $("#recruit-delete").on("click",()=>{
    popup_display("/recruitments/destroy", "本当に削除しますか？");
  });

  //参加取り消しをクリックした際
  $("#entry-delete").on("click",()=>{
    const recruit_id = $("#entry-delete").attr("data-recruit-id");
    popup_display(`/recruitments/${recruit_id}/entries`, "本当に取り消しますか？");
  });
});