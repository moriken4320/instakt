#ユーザーを50人追加
50.times do |i|
  user = User.new(name: i, email: "#{i}@gmail.com", password: "aaaaaa", password_confirmation: "aaaaaa", provider: "aaa", uid: "aaa", image: "")
  user.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
  user.save
end

#フレンド依頼を10人追加
# 10.times do |i|
#   relationship = Relationship.create(follower_id: 51, following_id: i)
# end

#フレンド申請を10人追加
# 10.times do |i|
#   relationship = Relationship.create(follower_id: (50 - i), following_id: 51)
# end