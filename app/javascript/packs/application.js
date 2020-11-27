// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')


require("../headers/menu_display")
require("../flash")

if(location.pathname.includes('profile')){
  require("../profiles/user_update")
}
if(location.pathname.includes('friends')){
  require("../friends/friend_display")
  require("../friends/friend_good")
  require("../friends/user_search")
}
if(location.pathname.includes('recruitments')){
  require("../recruitments/menu_display")
}

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
