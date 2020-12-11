require 'rails_helper'

RSpec.describe "Friends", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @other_user = FactoryBot.create(:user)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get friends_path
      expect(response.status).to eq 200 
    end
    it "indexアクションにリクエストすると、フレンドがいた場合レスポンスにフレンドのユーザー名が存在する" do
      @user.follow(@other_user)
      @other_user.follow(@user)
      get friends_path
      expect(response.body).to include(@other_user.name) 
    end
    it "indexアクションにリクエストすると、フレンドがいない場合レスポンスにフレンドが存在しない文言が存在する" do
      get friends_path
      expect(response.body).to include("フレンドが存在しません") 
    end
  end

  describe "GET #mutual" do
    it "mutualアクションにリクエストすると正常にレスポンスが返ってくる" do
      get friends_mutual_path
      expect(response.status).to eq 200 
    end
    it "mutualアクションにリクエストすると、フレンドがいた場合レスポンスにフレンドのユーザー名が存在する" do
      @user.follow(@other_user)
      @other_user.follow(@user)
      get friends_mutual_path
      expect(response.body).to include(@other_user.name) 
    end
    it "mutualアクションにリクエストすると、フレンドがいない場合レスポンスにフレンド情報が存在しない" do
      get friends_mutual_path
      expect(response.body).to eq "[]"
    end
  end
  
  describe "GET #oneway_followers" do
    it "oneway_followersアクションにリクエストすると正常にレスポンスが返ってくる" do
      get friends_oneway_followers_path
      expect(response.status).to eq 200 
    end
    it "oneway_followersアクションにリクエストすると、申請中のユーザーがいた場合レスポンスにフレンドのユーザー名が存在する" do
      @user.follow(@other_user)
      get friends_oneway_followers_path
      expect(response.body).to include(@other_user.name) 
    end
    it "oneway_followersアクションにリクエストすると、申請中のユーザーがいない場合レスポンスにフレンド情報が存在しない" do
      get friends_oneway_followers_path
      expect(response.body).to eq "[]"
    end
  end

  describe "GET #oneway_followings" do
    it "oneway_followingsアクションにリクエストすると正常にレスポンスが返ってくる" do
      get friends_oneway_followings_path
      expect(response.status).to eq 200 
    end
    it "oneway_followingsアクションにリクエストすると、フレンド依頼中のユーザーがいた場合レスポンスにフレンドのユーザー名が存在する" do
      @other_user.follow(@user)
      get friends_oneway_followings_path
      expect(response.body).to include(@other_user.name) 
    end
    it "oneway_followingsアクションにリクエストすると、フレンド依頼中のユーザーがいない場合レスポンスにフレンド情報が存在しない" do
      get friends_oneway_followings_path
      expect(response.body).to eq "[]"
    end
  end

  describe "POST #heart" do
    before do
      post "/friends/#{@other_user.id}/heart"
    end
    it "heartアクションにリクエストすると正常にレスポンスが返ってくる" do
      expect(response.status).to eq 200 
    end
    it "heartアクションにリクエストするとレスポンスにハートをつけた対象ユーザー情報が返ってくる" do
      expect(response.body).to include(@other_user.name) 
    end
    it "heartアクションにリクエストするとレスポンスにflash情報が返ってくる" do
      expect(response.body).to include("flash") 
    end
  end
end
