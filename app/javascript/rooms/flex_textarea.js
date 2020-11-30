// $(function(){
//   $(".chat-area").on("input", ()=>{
//     $(".flex-area-dummy").text($(".chat-area").val() + '\u200b');
//   });
// });
const flex_textarea = ()=>{
  const dummy = document.querySelector('.flex-area-dummy');
  document.querySelector('.chat-area').addEventListener('input', e => {
    dummy.textContent = e.target.value + '\u200b';
  });
};

window.addEventListener("load",flex_textarea);