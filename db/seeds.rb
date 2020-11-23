20.times do |i|
  user = User.new(name: i, email: "#{i}@gmail.com", password: "aaaaaa", password_confirmation: "aaaaaa", provider: "aaa", uid: "aaa", image: "")
  user.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
  user.save
end