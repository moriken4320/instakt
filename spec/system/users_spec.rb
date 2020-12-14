require 'rails_helper'

RSpec.describe "ユーザー関連機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  
  describe "ユーザーログイン機能" do
    it "ログインしていない状態でトップページ以外にアクセスした場合、トップページに移動する" do
      # 募集一覧ページに遷移する
      visit recruitments_path
      # トップページに遷移しているか確認する
      expect(current_path).to eq root_path 
    end
    it "ログインしている状態で、トップページにアクセスすると募集一覧ページに遷移する" do
      # ログインする
      sign_in @user
      # トップページに遷移する
      visit root_path
      # 募集一覧ページに遷移しているか確認する
      expect(current_path).to eq recruitments_path 
    end
  end

  describe "ユーザーログアウト機能" do
    it "ログアウトに成功し、トップページに遷移する" do
      # ログインする
      sign_in @user
      # 募集一覧ページに遷移する
      visit recruitments_path
      # ヘッダー(右)のユーザーアイコンをクリックする
      find("#user-icon").click
      # ログアウトをクリックする
      click_on("ログアウト")
      # ログアウトに成功し、トップページに遷移しているか確認
      expect(current_path).to eq root_path 
    end
  end

  describe "プロフィール表示機能" do
    it "プロフィール画面に遷移したら、ログインユーザーの情報が表示される" do
      # ログインする
      sign_in @user
      # 募集一覧ページに遷移する
      visit recruitments_path
      # ヘッダー(右)のユーザーアイコンをクリックする
      find("#user-icon").click
      # プロフィールをクリックする
      click_on("プロフィール")
      # プロフィールページに遷移したか確認する
      expect(current_path).to eq profile_path
      # プロフィールページにログインしているユーザーのimageが表示されているか確認
      expect(page.find("#user-image")["src"]).to have_content(@user.image.filename.base) 
      # プロフィールページにログインしているユーザーのidが表示されているか確認
      expect(page).to have_content(@user.id)
      # プロフィールページにログインしているユーザーのnameが表示されているか確認
      expect(find("#user-name").value).to have_content(@user.name)
      # プロフィールページにログインしているユーザーのemailが表示されているか確認
      expect(find("#user-email").value).to have_content(@user.email)
    end
  end

  describe "プロフィール編集機能" do
    before do
      # ログインする
      sign_in @user
      # プロフィールページに遷移する
      visit profile_path
    end

    context "プロフィール情報に変更を加え、更新したとき" do
      before do
        # 添付する画像を定義する
        image_path = Rails.root.join('public/images/test_image.png')
        # 画像選択フォームに画像を添付する
        attach_file("user[image]", image_path, make_visible: true)
        # ユーザー名のテキストフォームに値を入力
        fill_in "user[name]", with: "test_name"
        # ユーザーEメールのテキストフォームに値を入力
        fill_in "user[email]", with: "test@gmail.com"
        # 更新ボタンをクリックし、DBに反映させる
        find("#actions").click
      end
      it "変更後のプロフィール情報が表示される" do
        # 変更後のimageに変更しているか確認する
        expect(page.find("#user-image")["src"]).to have_content("blob") 
        # 変更後のnameに変更しているか確認する
        expect(find("#user-name").value).to have_content("test_name") 
        # 変更後のemailに変更しているか確認する
        expect(find("#user-email").value).to have_content("test@gmail.com") 
      end
      it "画像を変更した場合、ヘッダーのユーザーアイコンが変更後の画像に変更されている" do
        # 変更後のimageに変更しているか確認する
        expect(find("#user-icon")["src"]).to have_content("blob") 
      end
    end
    
    context "プロフィール情報が更新できないとき" do
      it "変更部分がなく、更新ボタンが非アクティブ状態になっている" do
        # 同じユーザー名をテキストフォームに入力
        fill_in "user[name]", with: @user.name
        # 同じユーザーメールをテキストフォームに入力
        fill_in "user[email]", with: @user.email
        # 更新ボタンをクリックできないことを確認する
        expect(find("#actions")).to have_no_content("for")
      end
      it "変更部分に空白があり、更新ボタンが非アクティブ状態になっている" do
        # ユーザー名のテキストフォームを空白にする
        fill_in "user[name]", with: ""
        # 更新ボタンをクリックできないことを確認する
        expect(find("#actions")).to have_no_content("for")
      end
    end
  end
end
