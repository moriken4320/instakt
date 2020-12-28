
const friend_add_html = `
<img src="gifs/friend_add.gif" alt="フレンド追加" class="">
<div class="about-descript">
<p class="main-descript"><span class="heart">ハート</span>をクリックして<br>フレンドを作ろう</p>
<p class="sub-descript">
フレンド画面でユーザーに<span class="heart">ハート</span>を付与しましょう。<br>
お互いに<span class="heart">ハート</span>を付け合うことでフレンドとなります。<br>
フレンドとなったユーザーには、あなたが作成した募集が表示されます。
</p>
</div>
`;

const recruit_create_html = `
<img src="gifs/recruit_create.gif" alt="募集作成">
<div class="about-descript">
  <p class="main-descript"><span class="recruit">募集</span>を作成してみよう</p>
  <p class="sub-descript">
    「これから」と「いま」の２パターンで<br><span class="recruit">募集</span>を作成できます。<br>
    用途に合わせて<span class="recruit">募集</span>を作成し、飲み仲間を見つけましょう！<br>
  </p>
</div>
`;

const entry_html = `
<img src="gifs/entry.gif" alt="募集参加">
<div class="about-descript">
  <p class="main-descript">募集に<span class="entry">参加</span>しよう</p>
  <p class="sub-descript">
    フレンドの募集が募集一覧画面に表示されます。<br>
    自分の都合に合う募集に<span class="entry">参加</span>してみましょう！
  </p>
</div>
`;

const message_html = `
<img src="gifs/message.gif" alt="メッセージ">
<div class="about-descript">
  <p class="main-descript"><span class="message">メッセージ</span>でやり取りをしよう</p>
  <p class="sub-descript">
    募集作成者と参加者のみが入場できるトークルームで<br><span class="message">メッセージ</span>のやり取りができます。<br>
    飲む場所を決めたり、集合場所を決めたり、<br>細かなコミュニケーションを取っていきましょう！
  </p>
</div>
`;

const change_tab = (i) => {
  $(".about-tab").eq(current_tab).removeClass("select-tab");
  current_tab = i;
  $(".about-tab").eq(current_tab).addClass("select-tab");
  $("#about-item").html(about[i].html);
  $("#about-item").hide().fadeIn(200);
};

const about = [{tab: "#friend-add-tab", html: friend_add_html}, {tab: "#recruit-create-tab", html: recruit_create_html}, {tab: "#entry-tab", html: entry_html}, {tab: "#message-tab", html: message_html}]

let current_tab = 0;

$(function(){
  for(let i = 0; i < about.length; i++){
    $(about[i].tab).on("click",()=>{
      change_tab(i);
    });
  }
  $("#previous").on("click",()=>{
    let previous_tab = current_tab - 1;
    if(previous_tab < 0){
      previous_tab = about.length - 1;
    }
    change_tab(previous_tab);
  });
  $("#next").on("click",()=>{
    let next_tab = current_tab + 1;
    if(next_tab > about.length - 1){
      next_tab = 0;
    }
    change_tab(next_tab);
  });
});