require 'rails_helper'

RSpec.describe "フレンド関連機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @other_user = FactoryBot.create(:user)
  end

  describe "フレンド表示機能" do
    context "フレンドが存在する場合" do
      before do
        # 相互でハートを付与し、フレンドになる
        @user.follow(@other_user)
        @other_user.follow(@user)
      end
      it "フレンド画面に遷移したら、フレンドユーザー情報が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンドユーザー情報が表示されるか確認する
        expect(page).to have_content(@other_user.name) 
      end
      it "フレンド一覧タブをクリックしたら、フレンドユーザー情報が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド申請中タブをクリックする
        find("#applying-tab").click
        # フレンド一覧タブをクリックする
        find("#list-tab").click
        # フレンドユーザー情報が表示されるか確認する
        expect(page).to have_content(@other_user.name) 
      end
    end

    context "フレンドが存在しない場合" do
      it "フレンド画面に遷移したら、フレンドが存在しない旨を伝える文言が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンドが存在しない文言が表示されるか確認する
        expect(page).to have_content("フレンドが存在しません") 
      end
      it "フレンド一覧タブをクリックしたら、フレンドが存在しない旨を伝える文言が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド申請中タブをクリックする
        find("#applying-tab").click
        # フレンド一覧タブをクリックする
        find("#list-tab").click
        # フレンドが存在しない文言が表示されるか確認する
        expect(page).to have_content("フレンドが存在しません") 
      end
    end
  end

  describe "自分がフレンド申請しているユーザー表示機能" do
    context "自分がフレンド申請中のユーザーが存在する場合" do
      it "フレンド申請中タブをクリックしたら、自分がフレンド申請しているユーザー情報が表示される" do
        # 一方的にハートを付与し、申請中となる
        @user.follow(@other_user)
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド申請中タブをクリックする
        find("#applying-tab").click
        # 自分がフレンド申請中のユーザー情報が表示されるか確認する
        expect(page).to have_content(@other_user.name) 
      end
    end

    context "自分がフレンド申請中のユーザーが存在しない場合" do
      it "フレンド申請中タブをクリックしたら、フレンド申請しているユーザーが存在しないことを伝える文言が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド申請中タブをクリックする
        find("#applying-tab").click
        # フレンド申請しているユーザーが存在しないことを伝える文言が表示されるか確認する
        expect(page).to have_content("現在、申請中のユーザーはいません") 
      end
    end
  end

  describe "自分に対してフレンド依頼をしているユーザー表示機能" do
    context "フレンド依頼しているユーザーが存在する場合" do
      it "フレンド依頼タブをクリックしたら、自分に対してフレンド依頼をしているユーザー情報が表示される" do
        # 一方的にハートが付与され、依頼中となる
        @other_user.follow(@user)
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド依頼タブをクリックする
        find("#approval-pending-tab").click
        # 自分に対してフレンド依頼をしているユーザー情報が表示されるか確認する
        expect(page).to have_content(@other_user.name) 
      end
    end

    context "フレンド依頼しているユーザーが存在しない場合" do
      it "フレンド依頼タブをクリックしたら、自分に対してフレンド依頼をしているユーザーが存在しないことを伝える文言が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド依頼タブをクリックする
        find("#approval-pending-tab").click
        # 自分に対してフレンド依頼をしているユーザーが存在しないことを伝える文言が表示されるか確認する
        expect(page).to have_content("現在、フレンド依頼はありません") 
      end
    end
  end

  describe "ユーザー検索欄表示機能" do
    it "ユーザー検索タブをクリックしたら、ユーザー検索欄が表示される" do
      # フレンド一覧ページに遷移する
      visit friends_path
      # ユーザー検索タブをクリックする
      find("#user-search-tab").click
      # 検索フォームが存在するか確認する
      expect(page).to have_selector("#form-container[style='display: block;']") 
    end
  end

  describe "ユーザー検索機能" do
    context "検索し、ユーザーが検索にヒットしたとき" do
      it "検索にヒットしたユーザー情報が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # ユーザー検索タブをクリックする
        find("#user-search-tab").click
        # 存在するユーザーのIDを検索フォームに入力する
        fill_in "keyword", with: @other_user.id
        # 検索ボタンをクリックする
        click_on("検索")
        # 検索したユーザーの情報が表示されるか確認する
        expect(page).to have_content(@other_user.name) 
      end
    end
    
    context "検索し、ユーザーが検索にヒットしなかったとき" do
      it "ユーザーが検索にヒットしなかった旨を伝える文言が表示される" do
        # フレンド一覧ページに遷移する
        visit friends_path
        # ユーザー検索タブをクリックする
        find("#user-search-tab").click
        # 適当なユーザーIDを用意する
        user_id = "1"
        # 存在するユーザーのIDを検索フォームに入力する
        fill_in "keyword", with: user_id
        # 検索ボタンをクリックする
        click_on("検索")
        # 検索したユーザーが存在しないことを伝える文言が表示されるか確認する
        expect(page).to have_content("ユーザーID：#{user_id}　に該当するユーザーが見つかりませんでした") 
      end
    end
  end

  describe "ハート機能" do
    context "ハートを付与したとき" do
      it "対象のユーザーのハートが赤ピンク色になる" do
        # 一方的にハートが付与され、依頼中となる
        @other_user.follow(@user)
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド依頼タブをクリックする
        find("#approval-pending-tab").click
        # ハートを付与した時に、DBに保存されていることを確認する
        expect{
          find("i[data-id='#{@other_user.id}']").click
          sleep 0.5
        }.to change {Relationship.count}.by(1) 
        # ハートマークにgoodクラスが付与されているか確認する
        expect(find("i[data-id='#{@other_user.id}']")["class"]).to have_content("good")
      end
    end
    
    context "ハートを解除したとき" do
      it "対象のユーザーのハートが白色になる" do
        # 一方的にハートを付与し、申請中となる
        @user.follow(@other_user)
        # フレンド一覧ページに遷移する
        visit friends_path
        # フレンド申請中タブをクリックする
        find("#applying-tab").click
        # ハートを付与した時に、DBに保存されていることを確認する
        expect{
          find("i[data-id='#{@other_user.id}']").click
          sleep 0.5
        }.to change {Relationship.count}.by(-1) 
        # ハートマークにgoodクラスが付与されているか確認する
        expect(find("i[data-id='#{@other_user.id}']")["class"]).to have_no_content("good")
      end
    end
  end
end
