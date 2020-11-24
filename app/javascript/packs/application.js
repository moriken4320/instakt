// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')


require("../header/user_menu")
require("../flash")

if(location.pathname.includes('profile')){
  require("../profile/user_update")
}
if(location.pathname.includes('friends')){
  require("../friend/friend_display")
  require("../friend/friend_good")
  require("../friend/user_search")
}

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
