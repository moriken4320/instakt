require 'rails_helper'

RSpec.describe "Messages", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @other_user = FactoryBot.create(:user)
    @recruit = FactoryBot.build(:recruit)
    @message = FactoryBot.build(:message)
  end
  describe "POST #recruitment_messages" do
    context "正常系：対象の募集が存在する場合" do
      context "対象の募集の作成者が自分の場合" do
        before do
          @recruit.user = @user
          @recruit.save
          post recruitment_messages_path(@recruit), params: {message: {text: @message.text}}
        end
        it "recruitment_messagesアクションにリクエストすると正常にレスポンスが返される" do
          expect(response.status).to eq 200 
        end
        it "recruitment_messagesアクションにリクエストするとレスポンスにメッセージ情報が含まれる" do
          expect(response.body).to include(@message.text)
        end
      end
      
      context "対象の募集に参加していた場合" do
        before do
          @recruit.user = @other_user
          @recruit.save
          @entry = FactoryBot.build(:entry)
          @entry.user = @user
          @entry.recruit = @recruit
          @entry.save
          post recruitment_messages_path(@recruit), params: {message: {text: @message.text}}
        end
        it "recruitment_messagesアクションにリクエストすると正常にレスポンスが返される" do
          expect(response.status).to eq 200 
        end
        it "recruitment_messagesアクションにリクエストするとレスポンスにメッセージ情報が含まれる" do
          expect(response.body).to include(@message.text)
        end
      end
    end
    
    context "異常系：対象の募集が存在しない場合" do
      it "recruitment_messagesアクションにリクエストするとリダイレクトされる" do
        post recruitment_messages_path(1)
        expect(response.status).to eq 302 
      end
    end
  end
  
end
