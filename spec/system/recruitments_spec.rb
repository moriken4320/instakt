require 'rails_helper'

RSpec.describe "募集関連機能", type: :system do
  before do
    
  end

  describe "募集一覧表示機能" do
    it "フレンドが1人もいない場合、その旨の説明とフレンド画面に遷移するボタンが表示される" do
      
    end
    
    it "自分とフレンドが誰も募集を作成していない場合、その旨の説明が表示される" do
      
    end
    
    it "自分かフレンドが募集を作成していた場合、該当する全ての募集が表示される" do
      
    end
  end

  describe "「これから」募集作成機能(募集一覧画面のみ)" do
    it "募集を作成すると、募集一覧画面に遷移して、作成した内容が表示される" do
      # DBも保存されているか確認
    end
  end

  describe "「いま」募集作成機能(募集一覧画面のみ)" do
    it "募集を作成すると、募集一覧画面に遷移して、作成した内容が表示される" do
      # DBも保存されているか確認
    end
  end

  describe "募集内容編集機能" do
    context "募集一覧画面から操作" do
      it "募集一覧に表示されている募集内容が編集した内容で更新される" do
        
      end
    end
    
    context "ルーム画面から操作" do
      it "募集確認で表示させたいる募集内容が編集した内容で更新される" do
        
      end
      it "ヘッダーの募集人数のカウントが編集した内容で更新される" do
        
      end
    end
  end
  
  describe "募集内容確認表示機能(ルーム画面のみ)" do
    it "対象の募集の内容が表示される" do
      
    end
  end

  describe "募集終了機能" do
    context "募集一覧画面から操作" do
      it "「募集が終了しました」という帯が表示される" do
        
      end
    end
    
    context "ルーム画面から操作" do
      it "ヘッダーのページ名に「募集終了」と表示される" do
        
      end
    end
  end
  
  describe "募集開始機能" do
    context "募集一覧画面から操作" do
      it "「募集が終了しました」という帯が消える" do
        
      end
    end
    
    context "ルーム画面から操作" do
      it "ヘッダーのページ名に「募集中」と表示される" do
        
      end
    end
  end
  
  describe "募集削除機能(ルーム画面のみ)" do
    it "募集を削除することで、募集一覧から対象の募集内容が消える" do
      
    end
    it "募集を削除することで、関連するデータが全て削除される" do
      
    end
  end
end
