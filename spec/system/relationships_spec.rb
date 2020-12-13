require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  before do

  end

  describe "フレンド表示機能" do
    it "フレンド画面に遷移したら、フレンドユーザー情報が表示される" do
      
    end
    it "フレンド一覧タブをクリックしたら、フレンドユーザー情報が表示される" do
      
    end
  end

  describe "自分がフレンド申請しているユーザー表示機能" do
    it "フレンド申請中タブをクリックしたら、自分がフレンド申請しているユーザー情報が表示される" do
      
    end
  end

  describe "自分に対してフレンド依頼をしているユーザー表示機能" do
    it "フレンド依頼タブをクリックしたら、自分に対してフレンド依頼をしているユーザー情報が表示される" do
      
    end
  end

  describe "ユーザー検索欄表示機能" do
    it "ユーザー検索タブをクリックしたら、ユーザー検索欄が表示される" do
      
    end
  end

  describe "ユーザー検索機能" do
    context "検索し、ユーザーが検索にヒットしたとき" do
      it "検索にヒットしたユーザー情報が表示される" do
        
      end
    end
    
    context "検索し、ユーザーが検索にヒットしなかったとき" do
      it "ユーザーが検索にヒットしなかった旨を伝える文言が表示される" do
        
      end
    end
  end

  describe "ハート機能" do
    context "ハートを付与したとき" do
      it "対象のユーザーのハートが赤ピンク色になる" do
        # DBも保存されているか確認
      end
    end
    
    context "ハートを解除したとき" do
      it "対象のユーザーのハートが白色になる" do
        # DBも削除されているか確認
      end
    end
  end
end
