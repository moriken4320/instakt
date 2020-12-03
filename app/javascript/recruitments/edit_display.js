import {escapeStr} from "../escape";
import {update} from "./update";
import {close, display} from "../back";

//募集編集用ajax関数
const edit_display = (url, html_display)=>{
  $.ajax({
    url: url,
    type: "post",
    dataType: "json",
  })
  .done((data)=>{
    html_display(data);
    $("#back").fadeIn(200);
    close();
    update();
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

const people_array = [...Array(15).keys()].map(i => i+=1);
const hour_array = [...Array(24).keys()].map(i => i = ("00"+i).slice(-2));
const minute_array = ["00", "15", "30", "45"];
const option_create = (select_range, select_num, parent) =>{
  select_range.forEach((select)=>{
    const option = $("<option>").attr("value", select).text(select);
    if(select == select_num){
      option.attr("selected", true);
    }
    parent.append(option);
  });
};

//「これから」のhtml
const later_html = (data)=>{
  const html = `
  <form action="/recruitments/later/update" accept-charset="UTF-8" method="post" id="later-update">
        <div class="recruits-container center">
          <div class="recruit-wrap">
            <div class="recruit-detail">
              <img class="recruit-user-image" src="${data.user.image}" style="width: 75px; height: 75px; object-fit: cover;">
              <div class="recruit-info">
                <div class="info-top">
                  <div class="recruit-user-name">${escapeStr(data.user.info.name)}<span>ID: ${data.user.info.id}</span></div>
                  <div class="recruit-type later">これから</div>
                </div>
                <ul class="info-bottom">
                  <li>
                    <div class="recruit-item">募集人数<span>※満たされると自動で募集を終了します。<span></div>
                    <div class="recruit-value">
                      <i class="fas fa-user-circle"></i>
                      <select class="item-select" name="recruit_later[close_condition_count]" id="recruit_later_close_condition_count">

                      </select>人
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">希望開始時間</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_later[start_at_hour_top]" id="recruit_later_start_at_hour_top">

                      </select> :
                      <select class="item-select" name="recruit_later[start_at_minute_top]" id="recruit_later_start_at_minute_top">

                      </select> ~ 
                      <select class="item-select" name="recruit_later[start_at_hour_bottom]" id="recruit_later_start_at_hour_bottom">

                      </select> :
                      <select class="item-select" name="recruit_later[start_at_minute_bottom]" id="recruit_later_start_at_minute_bottom">

                        </select>
                     </div>
                  </li>
                  <li>
                    <div class="recruit-item">希望終了時間</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_later[end_at_hour_top]" id="recruit_later_end_at_hour_top">

                      </select> :
                      <select class="item-select" name="recruit_later[end_at_minute_top]" id="recruit_later_end_at_minute_top">

                      </select> ~ 
                      <select class="item-select" name="recruit_later[end_at_hour_bottom]" id="recruit_later_end_at_hour_bottom">

                      </select> :
                      <select class="item-select" name="recruit_later[end_at_minute_bottom]" id="recruit_later_end_at_minute_bottom">

                      </select>
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">希望場所</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_later[place]" id="recruit_later_place" value="${escapeStr(data.info.later.place)}">
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">ひとこと</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_later[message]" id="recruit_later_message" value="${escapeStr(data.info.later.message)}">
                    </div>
                  </li>
                </ul>
              </div>
              <div class="menu-btn-wrap"></div>
            </div>
            <div class="entry-wrap">
              <div class="btn return-btn" id="return">戻る</div>
              <input type="submit" name="commit" value="更新" class="btn submit-btn" data-disable-with="更新">
            </div>
          </div>
        </div>
        <input type="hidden" name="authenticity_token" id="authenticity_token" value="${$("#authenticity_token").val()}">
      </form>
  `;
  $("#back").html(html);
  option_create(people_array, data.info.recruit.close_condition_count, $("#recruit_later_close_condition_count"));
  option_create(hour_array, data.info.later.start_at_hour_top, $("#recruit_later_start_at_hour_top"));
  option_create(minute_array, data.info.later.start_at_minute_top, $("#recruit_later_start_at_minute_top"));
  option_create(hour_array, data.info.later.start_at_hour_bottom, $("#recruit_later_start_at_hour_bottom"));
  option_create(minute_array, data.info.later.start_at_minute_bottom, $("#recruit_later_start_at_minute_bottom"));
  option_create(hour_array, data.info.later.end_at_hour_top, $("#recruit_later_end_at_hour_top"));
  option_create(minute_array, data.info.later.end_at_minute_top, $("#recruit_later_end_at_minute_top"));
  option_create(hour_array, data.info.later.end_at_hour_bottom, $("#recruit_later_end_at_hour_bottom"));
  option_create(minute_array, data.info.later.end_at_minute_bottom, $("#recruit_later_end_at_minute_bottom"));
};

//「いま」のhtml
const now_html = (data)=>{
  const html = `
  <form action="/recruitments/now/update" accept-charset="UTF-8" method="post" id="now-update">
        <div class="recruits-container center">
          <div class="recruit-wrap">
            <div class="recruit-detail">
              <img class="recruit-user-image" src="${data.user.image}" style="width: 75px; height: 75px; object-fit: cover;">
              <div class="recruit-info">
                <div class="info-top">
                  <div class="recruit-user-name">${escapeStr(data.user.info.name)}<span>ID: ${data.user.info.id}</span></div>
                  <div class="recruit-type now">いま</div>
                </div>
                <ul class="info-bottom">
                  <li>
                    <div class="recruit-item">募集人数<span>※満たされると自動で募集を終了します。<span></div>
                    <div class="recruit-value">
                      <i class="fas fa-user-circle"></i>
                      <select class="item-select" name="recruit_now[close_condition_count]" id="recruit_now_close_condition_count">
                      </select>人
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">現在の人数</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_now[member_count]" id="recruit_now_member_count">
                      </select>人
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">終了予定時間</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_now[end_at_hour_top]" id="recruit_now_end_at_hour_top">
                      </select> :
                      <select class="item-select" name="recruit_now[end_at_minute_top]" id="recruit_now_end_at_minute_top">
                      </select> ~ 
                      <select class="item-select" name="recruit_now[end_at_hour_bottom]" id="recruit_now_end_at_hour_bottom">
                      </select> :
                      <select class="item-select" name="recruit_now[end_at_minute_bottom]" id="recruit_now_end_at_minute_bottom">
                      </select>
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">現在の場所</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_now[place]" id="recruit_now_place" value="${escapeStr(data.info.now.place)}">
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">ひとこと</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_now[message]" id="recruit_now_message" value="${escapeStr(data.info.now.message)}">
                    </div>
                  </li>
                </ul>
              </div>
              <div class="menu-btn-wrap"></div>
            </div>
            <div class="entry-wrap">
              <div class="btn return-btn" id="return">戻る</div>
              <input type="submit" name="commit" value="更新" class="btn submit-btn" data-disable-with="更新">
            </div>
          </div>
        </div>
        <input type="hidden" name="authenticity_token" id="authenticity_token" value="${$("#authenticity_token").val()}">
      </form>
  `;
  $("#back").html(html);
  option_create(people_array, data.info.recruit.close_condition_count, $("#recruit_now_close_condition_count"));
  option_create(people_array, data.info.now.member_count, $("#recruit_now_member_count"));
  option_create(hour_array, data.info.now.end_at_hour_top, $("#recruit_now_end_at_hour_top"));
  option_create(minute_array, data.info.now.end_at_minute_top, $("#recruit_now_end_at_minute_top"));
  option_create(hour_array, data.info.now.end_at_hour_bottom, $("#recruit_now_end_at_hour_bottom"));
  option_create(minute_array, data.info.now.end_at_minute_bottom, $("#recruit_now_end_at_minute_bottom"));
};

$(function () {
  //「これから」の募集の編集をクリックした際の処理
  $("#edit-later").on("click",()=>{
    edit_display("recruitments/later/edit", later_html);
  });

  //「いま」の募集の編集をクリックした際の処理
  $("#edit-now").on("click",()=>{
    edit_display("recruitments/now/edit", now_html);
  });
});