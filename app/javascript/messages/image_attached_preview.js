
const create_image_HTML = (blob)=>{
  $("#image-wrap").remove();
  const image_element = $("<img>").attr("src", blob).addClass("attached-image");
  const close_btn = $("<div>").addClass("close-btn").attr("id", "close-btn").text("×");
  const image_wrap_element = $("<div>").addClass("image-wrap").attr("id", "image-wrap");
  image_wrap_element.append(image_element);
  image_wrap_element.append(close_btn);
  $("#image-list").append(image_wrap_element);
  reset_image();
};

$(function(){
  $("#message_image").on("change",(e)=>{
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    create_image_HTML(blob);
  });
});

const reset_image = ()=>{
  $(".close-btn").on("click",()=>{
    $("#message_image").val(null);
    $("#image-wrap").remove();
  });
};