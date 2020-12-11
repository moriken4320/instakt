require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET #profile" do
    before do
      get profile_path
    end
    it "profileアクションにリクエストすると正常にレスポンスが返ってくる" do
      expect(response.status).to eq 200 
    end
    it "profileアクションにリクエストするとレスポンスにログインユーザーのimage情報が存在する" do
      expect(response.body).to include(url_for(@user.image))
    end
    it "profileアクションにリクエストするとレスポンスにログインユーザーのid情報が存在する" do
      expect(response.body).to include(@user.id.to_s)
    end
    it "profileアクションにリクエストするとレスポンスにログインユーザーのname情報が存在する" do
      expect(response.body).to include(@user.name)
    end
    it "profileアクションにリクエストするとレスポンスにログインユーザーのemail情報が存在する" do
      expect(response.body).to include(@user.email)
    end
  end

  describe "POST #update" do
    context "正常系" do
      before do
        post profile_update_path, params: {user: {name: @user.name, email: @user.email}}
      end
      it "updateアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "updateアクションにリクエストするとレスポンスにログインユーザー情報が存在する" do
        expect(response.body).to include("user") 
      end
      it "updateアクションにリクエストするとレスポンスにflash情報が存在する" do
        expect(response.body).to include("更新しました") 
      end
    end

    context "異常系(正常なparamsがリクエストに含まれていなかった場合)" do
      before do
        post profile_update_path, params: {user: {name: "a"*15, email: @user.email}}
      end
      it "updateアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "updateアクションにリクエストするとレスポンスにログインユーザー情報が存在する" do
        expect(response.body).to include("user") 
      end
      it "updateアクションにリクエストするとレスポンスにflash情報が存在する" do
        expect(response.body).to include("更新に失敗しました") 
      end
    end
    
  end

  describe "GET #search" do
    context "正常系(ユーザーが検索にヒットした場合)" do
      before do
        @other_user = FactoryBot.create(:user)
        get users_search_path, params: {keyword: @other_user.id}
      end
      it "searchアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "searchアクションにリクエストするとレスポンスにユーザーID情報が存在する" do
        expect(response.body).to include(@other_user.id.to_s) 
      end
    end

    context "異常系(ユーザーが検索にヒットしなかった場合)" do
      before do
        get users_search_path, params: {keyword: "1"}
      end
      it "searchアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "searchアクションにリクエストするとレスポンスにユーザー情報が存在せず、nullが含まれている" do
        expect(response.body).to include("null") 
      end
    end
  end  
end
