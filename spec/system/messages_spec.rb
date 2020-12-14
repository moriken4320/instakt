require 'rails_helper'

RSpec.describe "メッセージ関連機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @recruit_later = FactoryBot.build(:recruit_later)
    @recruit_later.user = @user
    @recruit_later.save
    @recruit = Recruit.find_by(user_id: @user.id)
  end

  describe "メッセージ表示機能" do
    before do
      @message = FactoryBot.build(:message)
      @message.sender = @user
      @message.room = @recruit
      @message.save
    end
    it "募集ルームにメッセージが表示される" do
      # 自分の募集ルームページに遷移する
      visit recruitment_path(@recruit)
      # ページ内にメッセージのテキストが存在するか確認する
      expect(page).to have_content(@message.text) 
      # ページ内にメッセージのイメージが存在するか確認する
      expect(page).to have_selector(".attached-image") 
    end
  end

  describe "メッセージ作成機能" do
    it "メッセージを作成したら、メッセージが表示される" do
      # 自分の募集ルームページに遷移する
      visit recruitment_path(@recruit)
      # ページ内にメッセージのテキストが存在しないか確認する
      expect(page).to have_no_content("aaaaaa") 
      # ページ内にメッセージのイメージが存在しないか確認する
      expect(page).to have_no_selector(".attached-image") 
      # メッセージフォームにテキストを入力する
      fill_in "message[text]", with: "aaaaaa"
      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      # 画像選択フォームに画像を添付する
      attach_file("message[image]", image_path, make_visible: true)
      # フォームを送信したら、DBが保存されて、メッセージが表示される
      expect{
        find("#send-btn").click
        sleep 0.5
        # ページ内にメッセージのテキストが存在するか確認する
        expect(page).to have_content("aaaaaa") 
        # ページ内にメッセージのイメージが存在するか確認する
        expect(page).to have_selector(".attached-image") 
      }.to change {Message.count}.by(1)
    end
  end
end
