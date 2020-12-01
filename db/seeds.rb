# ユーザーを50人追加
50.times do |i|
  user = User.new(name: (i + 2), email: "#{(i + 2)}@gmail.com", password: "aaaaaa", password_confirmation: "aaaaaa", provider: "aaa", uid: "aaa", image: "")
  user.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
  user.save
end

# フレンド依頼を10人追加
10.times do |i|
  Relationship.create(follower_id: 1, following_id: (i + 2))
end

# フレンド申請を10人追加
10.times do |i|
  Relationship.create(follower_id: (50 - i), following_id: 1)
end

# 「これから」の募集を10人追加
10.times do |i|
  recruit = Recruit.create(user_id: (i + 2), close_flag: 0, close_condition_count: 3)
  Later.create(
    start_at_hour_top: "18",
    start_at_minute_top: "00",
    start_at_hour_bottom: "19",
    start_at_minute_bottom: "15",
    end_at_hour_top: "22",
    end_at_minute_top: "30",
    end_at_hour_bottom: "23",
    end_at_minute_bottom: "45",
    place: "東京",
    message: "よろしく",
    recruit_id: recruit.id
  )
end

# 「いま」の募集を10人追加
10.times do |i|
  recruit = Recruit.create(user_id: (50 - i), close_flag: 0, close_condition_count: 5)
  Now.create(
    member_count: 10,
    end_at_hour_top: "23",
    end_at_minute_top: "30",
    end_at_hour_bottom: "23",
    end_at_minute_bottom: "45",
    place: "渋谷",
    message: "きてくれ〜",
    recruit_id: recruit.id
  )
end