import {escapeStr} from "../escape";

//戻るボタンで新規募集画面を閉じる関数
const close = () => {
  $("#return").on("click",()=>{
    $("#back").html("");
    $("#back").hide();
  });
};

//新規募集作成用ajax関数
const new_display = (url, html)=>{
  $.ajax({
    url: url,
    type: "post",
    dataType: "json",
  })
  .done((data)=>{
    $("#back").html(html(data));
    $("#back").fadeIn(200);
    close();
  })
  .fail(()=>{
    alert("エラーが発生しました。");
  })
  .always(()=>{
    
  });
};

//「これから」のhtml
const later_html = (data)=>{
  const html = `
  <form action="/recruitments/later/create" accept-charset="UTF-8" method="post" id="later_create">
        <div class="recruits-container center">
          <div class="recruit-wrap">
            <div class="recruit-detail">
              <img class="recruit-user-image" src="${data.image}" style="width: 75px; height: 75px; object-fit: cover;">
              <div class="recruit-info">
                <div class="info-top">
                  <div class="recruit-user-name">${escapeStr(data.info.name)}<span>ID: ${data.info.id}</span></div>
                  <div class="recruit-type later">これから</div>
                </div>
                <ul class="info-bottom">
                  <li>
                    <div class="recruit-item">募集人数<span>※満たされると自動で募集を終了します。<span></div>
                    <div class="recruit-value">
                      <i class="fas fa-user-circle"></i>
                      <select class="item-select" name="recruit_later[close_condition_count]" id="recruit_later_close_condition_count">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                      </select>人
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">希望開始時間</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_later[start_at_hour_top]" id="recruit_later_start_at_hour_top">
                        <option value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select> :
                      <select class="item-select" name="recruit_later[start_at_minute_top]" id="recruit_later_start_at_minute_top">
                        <option value="00">00</option>
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                      </select> ~ 
                      <select class="item-select" name="recruit_later[start_at_hour_bottom]" id="recruit_later_start_at_hour_bottom">
                        <option value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select> :
                      <select class="item-select" name="recruit_later[start_at_minute_bottom]" id="recruit_later_start_at_minute_bottom">
                          <option value="00">00</option>
                          <option value="15">15</option>
                          <option value="30">30</option>
                          <option value="45">45</option>
                        </select>
                     </div>
                  </li>
                  <li>
                    <div class="recruit-item">希望終了時間</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_later[end_at_hour_top]" id="recruit_later_end_at_hour_top">
                        <option value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select> :
                      <select class="item-select" name="recruit_later[end_at_minute_top]" id="recruit_later_end_at_minute_top">
                        <option value="00">00</option>
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                      </select> ~ 
                      <select class="item-select" name="recruit_later[end_at_hour_bottom]" id="recruit_later_end_at_hour_bottom">
                        <option value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select> :
                      <select class="item-select" name="recruit_later[end_at_minute_bottom]" id="recruit_later_end_at_minute_bottom">
                        <option value="00">00</option>
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                      </select>
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">希望場所</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_later[place]" id="recruit_later_place">
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">ひとこと</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_later[message]" id="recruit_later_message">
                    </div>
                  </li>
                </ul>
              </div>
              <div class="menu-btn-wrap"></div>
            </div>
            <div class="entry-wrap">
              <div class="btn return-btn" id="return">戻る</div>
              <input type="submit" name="commit" value="作成" class="btn recruit-room-btn" data-disable-with="作成">
            </div>
          </div>
        </div>
        <input type="hidden" name="authenticity_token" id="authenticity_token" value="${$("#authenticity_token").val()}">
      </form>
  `;
  return html;
};

//「いま」のhtml
const now_html = (data)=>{
  const html = `
  <form action="/recruitments/now/create" accept-charset="UTF-8" method="post" id="now_create">
        <div class="recruits-container center">
          <div class="recruit-wrap">
            <div class="recruit-detail">
              <img class="recruit-user-image" src="${data.image}" style="width: 75px; height: 75px; object-fit: cover;">
              <div class="recruit-info">
                <div class="info-top">
                  <div class="recruit-user-name">${escapeStr(data.info.name)}<span>ID: ${data.info.id}</span></div>
                  <div class="recruit-type now">いま</div>
                </div>
                <ul class="info-bottom">
                  <li>
                    <div class="recruit-item">募集人数<span>※満たされると自動で募集を終了します。<span></div>
                    <div class="recruit-value">
                      <i class="fas fa-user-circle"></i>
                      <select class="item-select" name="recruit_now[close_condition_count]" id="recruit_now_close_condition_count">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                      </select>人
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">現在の人数</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_now[member_count]" id="recruit_now_member_count">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                      </select>人
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">終了予定時間</div>
                    <div class="recruit-value">
                      <select class="item-select" name="recruit_now[end_at_hour_top]" id="recruit_now_end_at_hour_top">
                        <option value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select> :
                      <select class="item-select" name="recruit_now[end_at_minute_top]" id="recruit_now_end_at_minute_top">
                        <option value="00">00</option>
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                      </select> ~ 
                      <select class="item-select" name="recruit_now[end_at_hour_bottom]" id="recruit_now_end_at_hour_bottom">
                        <option value="00">00</option>
                        <option value="01">01</option>
                        <option value="02">02</option>
                        <option value="03">03</option>
                        <option value="04">04</option>
                        <option value="05">05</option>
                        <option value="06">06</option>
                        <option value="07">07</option>
                        <option value="08">08</option>
                        <option value="09">09</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                      </select> :
                      <select class="item-select" name="recruit_now[end_at_minute_bottom]" id="recruit_now_end_at_minute_bottom">
                        <option value="00">00</option>
                        <option value="15">15</option>
                        <option value="30">30</option>
                        <option value="45">45</option>
                      </select>
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">現在の場所</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_now[place]" id="recruit_now_place">
                    </div>
                  </li>
                  <li>
                    <div class="recruit-item">ひとこと</div>
                    <div class="recruit-value">
                      <input class="item-text" placeholder="最大 20文字まで" maxlength="20" size="20" type="text" name="recruit_now[message]" id="recruit_now_message">
                    </div>
                  </li>
                </ul>
              </div>
              <div class="menu-btn-wrap"></div>
            </div>
            <div class="entry-wrap">
              <div class="btn return-btn" id="return">戻る</div>
              <input type="submit" name="commit" value="作成" class="btn recruit-room-btn" data-disable-with="作成">
            </div>
          </div>
        </div>
        <input type="hidden" name="authenticity_token" id="authenticity_token" value="${$("#authenticity_token").val()}">
      </form>
  `;
  return html;
};

$(function () {
  //募集の「これから」をクリックした際の処理
  $("#recruit-later").on("click",()=>{
    new_display("/recruitments/later/new", later_html);
  });

  //募集の「いま」をクリックした際の処理
  $("#recruit-now").on("click",()=>{
    new_display("/recruitments/now/new", now_html);
  });
});