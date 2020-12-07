
const create_image_HTML = (blob)=>{
  const image_element = $("<img>").attr("src", blob).addClass("attached-image");
  const image_wrap_element = $("<div>").append(image_element);
  $("#image-list").append(image_wrap_element);
};

$(function(){
  $("#message_image").on("change",(e)=>{
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    create_image_HTML(blob);
  });
});