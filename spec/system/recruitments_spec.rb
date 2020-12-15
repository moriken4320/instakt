require 'rails_helper'

RSpec.describe "募集関連機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @other_user = FactoryBot.create(:user)
  end

  describe "募集一覧表示機能" do
    it "フレンドが1人もいない場合、その旨の説明とフレンド画面に遷移するボタンが表示される" do
      # 募集一覧ページに遷移する
      visit recruitments_path
      # フレンドが存在しない文言があるか確認する
      expect(page).to have_content("フレンドになったユーザーの募集が表示されます。") 
      # フレンド画面に遷移するボタンがあるか確認する
      expect(page).to have_content("フレンドを追加する") 
    end
    
    it "自分とフレンドが誰も募集を作成していない場合、その旨の説明が表示される" do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集一覧ページに遷移する
      visit recruitments_path
      # 募集が存在しないことを伝える文言が表示されているか確認
      expect(page).to have_content("本日はまだ誰も募集していません。") 
    end
    
    it "自分かフレンドが募集を作成していた場合、該当する全ての募集が表示される" do
      # 募集一覧ページに遷移する
      visit recruitments_path
      # ページ内にother_userの名前が表示されていないことを確認する
      expect(page).to have_no_content(@other_user.name)
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # フレンドであるother_userが募集を作成
      @recruit_later = FactoryBot.build(:recruit_later)
      @recruit_later.user = @other_user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @other_user.id)
      # もう一度、募集一覧ページを読み込む
      visit recruitments_path
      # 募集を作成したother_userの名前が表示されているか確認する
      expect(page).to have_content(@other_user.name)
    end
  end

  describe "「これから」募集作成機能(募集一覧画面のみ)" do
    it "募集を作成すると、募集一覧画面に遷移して、作成した内容が表示される" do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集一覧ページに遷移する
      visit recruitments_path
      # 募集するボタンをクリックする
      find("#modal_btn").click
      # 「これから」ボタンをクリックする
      find("#recruit-later").click
      sleep 0.5
      # 作成モーダルが表示されているか確認する
      expect(page).to have_selector("input[value='作成']")
      # 作成ボタンをクリックしたら、DBに保存され、募集一覧ページに遷移しているか確認する
      expect{
        find("input[value='作成']").click
        expect(page).to have_no_selector("input[value='作成']")
      }.to change {Recruit.count}.by(1).and change {Later.count}.by(1)
    end
  end

  describe "「いま」募集作成機能(募集一覧画面のみ)" do
    it "募集を作成すると、募集一覧画面に遷移して、作成した内容が表示される" do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集一覧ページに遷移する
      visit recruitments_path
      # 募集するボタンをクリックする
      find("#modal_btn").click
      # 「いま」ボタンをクリックする
      find("#recruit-now").click
      sleep 0.5
      # 作成モーダルが表示されているか確認する
      expect(page).to have_selector("input[value='作成']")
      # 作成ボタンをクリックしたら、DBに保存され、募集一覧ページに遷移しているか確認する
      expect{
        find("input[value='作成']").click
        expect(page).to have_no_selector("input[value='作成']")
      }.to change {Recruit.count}.by(1).and change {Now.count}.by(1)
    end
  end

  describe "募集内容編集機能" do
    before do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集を作成
      @recruit_later = FactoryBot.build(:recruit_later)
      @recruit_later.user = @user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @user.id)
    end
    context "募集一覧画面から操作" do
      it "募集一覧に表示されている募集内容が編集した内容で更新される" do
        # 募集一覧ページに遷移する
        visit recruitments_path
        # メニューボタンをクリックする
        find("#menu-btn").click
        # 編集ボタンをクリックする
        find("#edit-later").click
        sleep 0.5
        # ひとことを変更する
        message = "test_message"
        fill_in "recruit_later[message]", with: message
        # 更新ボタンをクリックする
        find("input[name='commit']").click
        sleep 0.5
        # 募集一覧に表示されている募集の内容が変更されているか確認する
        expect(page).to have_content(message) 
      end
    end
    
    context "ルーム画面から操作" do
      it "募集確認で表示させたいる募集内容が編集した内容で更新される" do
        # 募集ルームページに遷移する
        visit recruitment_path(@recruit)
        # 設定ボタンをクリックする
        find("#modal_btn").click
        # 募集内容ボタンをクリックし、募集内容を表示する
        find("#confirmation-later").click
        sleep 0.5
        # 設定ボタンをクリックする
        find("#modal_btn").click
        # 募集編集ボタンをクリックする
        find("#edit-later").click
        sleep 0.5
        # ひとことを変更する
        message = "test_message"
        fill_in "recruit_later[message]", with: message
        # 更新ボタンをクリックする
        find("input[value='更新']").click
        sleep 0.5
        # 募集の内容が変更されているか確認する
        expect(page).to have_content(message) 
      end
    end
  end
  
  describe "募集内容確認表示機能(ルーム画面のみ)" do
    it "対象の募集の内容が表示される" do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集を作成
      @recruit_later = FactoryBot.build(:recruit_later)
      @recruit_later.user = @user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @user.id)
      # 募集ルームページに遷移する
      visit recruitment_path(@recruit)
      # 設定ボタンをクリックする
      find("#modal_btn").click
      # 募集内容ボタンをクリックし、募集内容を表示する
      find("#confirmation-later").click
      sleep 0.5
      # 募集内容が表示されているか確認
      expect(find("#confirmation")).to have_content(@recruit.user.id.to_s) 
      expect(find("#confirmation")).to have_content(@recruit.user.name) 
      expect(find("#confirmation")).to have_content(@recruit.later.place) 
      expect(find("#confirmation")).to have_content(@recruit.later.message) 
      expect(find("#confirmation")).to have_content("これから") 
    end
  end

  describe "募集終了機能" do
    before do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集を作成
      @recruit_later = FactoryBot.build(:recruit_later)
      @recruit_later.user = @user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @user.id)
    end

    context "募集一覧画面から操作" do
      it "「募集が終了しました」という帯が表示される" do
        # 募集一覧ページに遷移する
        visit recruitments_path
        # 募集終了ラベルが表示されていないことを確認する
        expect(find("#current_user_recruit")).to have_no_content("募集が終了しました") 
        # メニューボタンをクリックする
        find("#menu-btn").click
        # 募集終了ボタンをクリックする
        find("#close").click
        sleep 0.5
        # 募集終了ラベルが表示されているか確認
        expect(find("#current_user_recruit")).to have_content("募集が終了しました") 
      end
    end
    
    context "ルーム画面から操作" do
      it "ヘッダーのページ名に「募集終了」と表示される" do
        # 募集ルームページに遷移する
        visit recruitment_path(@recruit)
        # ヘッダーの文字が「募集中」であることを確認
        expect(find("#page_name")).to have_content("募集中")
        # 設定ボタンをクリックする
        find("#modal_btn").click
        # 募集終了ボタンをクリックする
        find("#close").click
        sleep 0.5
        # ヘッダーの「募集中」が「募集終了」に変更されているか確認
        expect(find("#page_name")).to have_content("募集終了")
      end
    end
  end
  
  describe "募集開始機能" do
    before do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集を作成
      @recruit_later = FactoryBot.build(:recruit_later)
      @recruit_later.user = @user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @user.id)
      # 募集を終了状態にする
      @recruit.update(close_flag: 1)
    end

    context "募集一覧画面から操作" do
      it "「募集が終了しました」という帯が消える" do
        # 募集一覧ページに遷移する
        visit recruitments_path
        # 募集終了ラベルが表示されているか確認
        expect(find("#current_user_recruit")).to have_content("募集が終了しました") 
        # メニューボタンをクリックする
        find("#menu-btn").click
        # 募集再開ボタンをクリックする
        find("#close").click
        sleep 0.5
        # 募集終了ラベルが消えているか確認
        expect(find("#current_user_recruit")).to have_no_content("募集が終了しました") 
      end
    end
    
    context "ルーム画面から操作" do
      it "ヘッダーのページ名に「募集中」と表示される" do
        # 募集ルームページに遷移する
        visit recruitment_path(@recruit)
        # ヘッダーの文字が「募集終了」であることを確認する
        expect(find("#page_name")).to have_content("募集終了")
        # 設定ボタンをクリックする
        find("#modal_btn").click
        # 募集終了ボタンをクリックする
        find("#close").click
        sleep 0.5
        # ヘッダーの「募集終了」が「募集中」に変更されているか確認する
        expect(find("#page_name")).to have_content("募集中")
      end
    end
  end
  
  describe "募集削除機能(ルーム画面のみ)" do
    before do
      # 相互でハートを付与し、フレンドになる
      @user.follow(@other_user)
      @other_user.follow(@user)
      # 募集を作成
      @recruit_later = FactoryBot.build(:recruit_later)
      @recruit_later.user = @user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @user.id)
      # other_userを参加させる
      @entry = FactoryBot.build(:entry)
      @entry.user = @other_user
      @entry.recruit = @recruit
      @entry.save
      # メッセージを作成
      @message = FactoryBot.build(:message)
      @message.sender = @user
      @message.room = @recruit
      @message.save
    end

    it "募集を削除することで、募集一覧から対象の募集内容が消える" do
      # 募集ルームページに遷移する
      visit recruitment_path(@recruit)
      # 設定ボタンをクリックする
      find("#modal_btn").click
      # 募集削除ボタンをクリックする
      find("#recruit-delete").click
      sleep 0.5
      # はいボタンをクリックしたら、対象の募集に関わるデータを全て削除し、募集一覧ページに遷移することを確認する
      expect{
        click_link("はい")
        expect(current_path).to eq recruitments_path 
      }.to change {Recruit.count}.by(-1).and change {Later.count}.by(-1).and change {Entry.count}.by(-1).and change {Message.count}.by(-1)
    end
  end
end
