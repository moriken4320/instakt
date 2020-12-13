require 'rails_helper'

RSpec.describe "ユーザー関連機能", type: :system do
  before do

  end
  describe "ユーザーログイン機能" do
    it "ログインしていない状態でトップページ以外にアクセスした場合、トップページに移動する" do
      
    end
    it "ログインに成功し、募集一覧ページに遷移する" do
      
    end
  end

  describe "ユーザーログアウト機能" do
    it "ログアウトしていない状態でトップページにアクセスした場合、募集一覧ページに移動する" do
      
    end
    it "ログアウトに成功し、トップページに遷移する" do
      
    end
  end

  describe "プロフィール表示機能" do
    it "プロフィール画面に遷移したら、ログインユーザーの情報が表示される" do
      
    end
  end

  describe "プロフィール編集機能" do
    context "プロフィール情報に変更を加え、更新したとき" do
      it "変更後のプロフィール情報が表示される" do
        
      end
      it "画像を変更した場合、ヘッダーのユーザーアイコンが変更後の画像に変更されている" do
        
      end
    end
    
    context "プロフィール情報が更新できないとき" do
      it "変更部分がなく、更新ボタンが非アクティブ状態になっている" do
        
      end
      it "変更部分に空白があり、更新ボタンが非アクティブ状態になっている" do
        
      end
    end
  end
end
