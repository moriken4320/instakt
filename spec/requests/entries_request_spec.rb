require 'rails_helper'

RSpec.describe "Entries", type: :request do
  before do
    user = FactoryBot.create(:user)
    sign_in user
    @recruit = FactoryBot.create(:recruit)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get recruitment_entries_path(@recruit)
      expect(response.status).to eq 200 
    end
    it "indexアクションにリクエストするとレスポンスに参加ユーザー情報が存在する" do
      get recruitment_entries_path(@recruit)
      expect(response.body).to include("users") 
    end
    it "indexアクションにリクエストするとレスポンスにflash情報が存在する" do
      get recruitment_entries_path(@recruit)
      expect(response.body).to include("flash") 
    end
  end

  describe "POST #create" do
    it "createアクションにリクエストするとリダイレクトされる" do
      post recruitment_entries_path(@recruit)
      expect(response.status).to eq 302 
    end
  end
  
  describe "DELETE #destroy" do
    it "createアクションにリクエストするとリダイレクトされる" do
      delete recruitment_entries_path(@recruit)
      expect(response.status).to eq 302 
    end
  end
  
end
