require 'rails_helper'

RSpec.describe "参加関連機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @other_user = FactoryBot.create(:user)
    @user.follow(@other_user)
    @other_user.follow(@user)
    @recruit_later = FactoryBot.build(:recruit_later)
    @recruit_later.user = @other_user
    @recruit_later.save
    @recruit = Recruit.find_by(user_id: @other_user.id)
    @entry = FactoryBot.build(:entry)
  end

  describe "参加機能" do
    it "参加ボタンをクリックしたら、その募集に参加する" do
      # 募集一覧ページに遷移する
      visit recruitments_path
      # 参加ボタンがあることを確認する
      expect(page).to have_content("参加") 
      # 参加ボタンをクリックしたら、DBに保存されていることを確認する
      expect{click_link("参加")}.to change {Entry.count}.by(1) 
      # 参加後に遷移したページが参加した募集のルームであるか確認する
      expect(current_path).to eq  recruitment_path(@recruit)
    end
  end

  describe "参加取り消し機能" do
    before do
      @entry.user = @user
      @entry.recruit = @recruit
      @entry.save
    end
    it "参加取り消しボタンをクリックしたら、その募集の参加を取り消す" do
      # 募集一覧ページに遷移する
      visit recruitments_path
      # 参加中のルームボタンがあることを確認する
      expect(page).to have_content("参加中のルーム") 
      # 参加中のルームボタンをクリックし、参加した募集のルームページに遷移する
      click_link("参加中のルーム")
      # 設定ボタンをクリックする
      find("#modal_btn").click
      # 参加取り消しボタンをクリックする
      find("#entry-delete").click
      # はいボタンをクリックしたら、参加を取り消し、募集一覧ページに遷移することを確認する
      sleep 0.5
      expect{
        click_link("はい")
        expect(current_path).to eq recruitments_path 
      }.to change {Entry.count}.by(-1)  
    end
  end

  describe "参加者リスト表示機能" do
    before do
      @entry.user = @user
      @entry.recruit = @recruit
      @entry.save
    end

    context "募集一覧画面から操作" do
      it "参加者リストボタンをクリックすると参加者リストを表示する" do
        # 募集一覧ページに遷移する
        visit recruitments_path
        # 参加者リストボタンをクリックする
        find("i[data-recruit-id='#{@recruit.id}']").click
        sleep 0.5
        # 参加者リストに参加者である@userの名前が表示されるか確認する
        expect(page).to have_content(@user.name)
        # 戻るボタンで参加者リストを閉じる
        find("#return").click
        # 参加者リストに参加者である@userの名前がなくなり、参加者リストが閉じられたか確認する
        expect(page).to have_no_content(@user.name)
      end
    end
    
    context "ルーム画面から操作" do
      it "参加者リストボタンをクリックすると参加者リストを表示する" do
        # 参加中の募集ページに遷移する
        visit recruitment_path(@recruit)
        # 参加者リストボタンをクリックする
        find("i[data-recruit-id='#{@recruit.id}']").click
        sleep 0.5
        # 参加者リストに参加者である@userの名前が表示されるか確認する
        expect(page).to have_content(@user.name)
        # 戻るボタンで参加者リストを閉じる
        find("#return").click
        # 参加者リストに参加者である@userの名前がなくなり、参加者リストが閉じられたか確認する
        expect(page).to have_no_content(@user.name)
      end
    end
  end
end
