require 'rails_helper'

RSpec.describe "Recruitments", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @other_user = FactoryBot.create(:user)
    @user.follow(@other_user)
    @other_user.follow(@user)
    @recruit_later = FactoryBot.build(:recruit_later)
    @recruit_now = FactoryBot.build(:recruit_now)
  end

  describe "GET #top" do
    it "topアクションにリクエストすると正常にレスポンスが返ってくる" do
      sign_out @user
      get root_path
      expect(response.status).to eq 200 
    end
  end
  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get recruitments_path
      expect(response.status).to eq 200 
    end
    it "indexアクションにリクエストすると、フレンドがいなければ場合、フレ
    ンド追加を促す文言が存在する" do
      @user.unfollow(@other_user)
      get recruitments_path
      expect(response.body).to include("まずはフレンドを追加しましょう。")
    end
    it "indexアクションにリクエストすると、募集がなければ場合、募集が存在しない文言が存在する" do
      get recruitments_path
      expect(response.body).to include("本日はまだ誰も募集していません。")
    end
    it "indexアクションにリクエストすると、募集があれば場合、募集情報が存在する" do
      @recruit_later.user = @other_user
      @recruit_later.save
      get recruitments_path
      expect(response.body).to include("recruit-wrap") 
    end
  end

  describe "POST #new_later" do
    context "正常系：ログインユーザーが募集を作成していない" do
      it "new_laterアクションにリクエストすると正常にレスポンスが返ってくる" do
        post recruitments_later_new_path
        expect(response.status).to eq 200 
      end
      it "new_laterアクションにリクエストするとレスポンスにログインユーザー情報が含まれる" do
        post recruitments_later_new_path
        expect(response.body).to include(@user.name)
      end
    end
    context "異常系：ログインユーザーが既に募集を作成していた場合" do
      it "new_laterアクションにリクエストするとリダイレクトされる" do
        @recruit_later.user = @user
        @recruit_later.save
        post recruitments_later_new_path
        expect(response.status).to eq 302
      end
    end
  end

  describe "POST #new_now" do
    context "正常系：ログインユーザーが募集を作成していない" do
      it "new_nowアクションにリクエストすると正常にレスポンスが返ってくる" do
        post recruitments_now_new_path
        expect(response.status).to eq 200 
      end
      it "new_nowアクションにリクエストするとレスポンスにログインユーザー情報が含まれる" do
        post recruitments_now_new_path
        expect(response.body).to include(@user.name)
      end
    end
    context "異常系：ログインユーザーが既に募集を作成していた場合" do
      it "new_nowアクションにリクエストするとリダイレクトされる" do
        @recruit_now.user = @user
        @recruit_now.save
        post recruitments_now_new_path
        expect(response.status).to eq 302
      end
    end
  end

  describe "POST #create_later" do
    context "正常系：ログインユーザーが募集を作成していない" do
      it "create_laterアクションにリクエストするとリダイレクトされる" do
        post recruitments_later_create_path, params: {recruit_later:{
          start_at_hour_top: @recruit_later.start_at_hour_top,
          start_at_minute_top: @recruit_later.start_at_minute_top,
          start_at_hour_bottom: @recruit_later.start_at_hour_bottom,
          start_at_minute_bottom: @recruit_later.start_at_minute_bottom,
          end_at_hour_top: @recruit_later.end_at_hour_top,
          end_at_minute_top: @recruit_later.end_at_minute_top,
          end_at_hour_bottom: @recruit_later.end_at_hour_bottom,
          end_at_minute_bottom: @recruit_later.end_at_minute_bottom,
          place: @recruit_later.place,
          message: @recruit_later.message,
          close_condition_count: @recruit_later.close_condition_count
        }}
        expect(response.status).to eq 302
      end
    end
    context "異常系：ログインユーザーが既に募集を作成していた場合" do
      it "create_laterアクションにリクエストするとリダイレクトされる" do
        @recruit_later.user = @user
        @recruit_later.save
        post recruitments_later_create_path
        expect(response.status).to eq 302
      end
    end
  end

  describe "POST #create_now" do
    context "正常系：ログインユーザーが募集を作成していない" do
      it "create_nowアクションにリクエストするとリダイレクトされる" do
        post recruitments_now_create_path, params: {recruit_now:{
          member_count: @recruit_now.member_count,
          end_at_hour_top: @recruit_now.end_at_hour_top,
          end_at_minute_top: @recruit_now.end_at_minute_top,
          end_at_hour_bottom: @recruit_now.end_at_hour_bottom,
          end_at_minute_bottom: @recruit_now.end_at_minute_bottom,
          place: @recruit_now.place,
          message: @recruit_now.message,
          close_condition_count: @recruit_now.close_condition_count
        }}
        expect(response.status).to eq 302
      end
    end
    context "異常系：ログインユーザーが既に募集を作成していた場合" do
      it "create_nowアクションにリクエストするとリダイレクトされる" do
        @recruit_now.user = @user
        @recruit_now.save
        post recruitments_now_create_path
        expect(response.status).to eq 302
      end
    end
  end
  
  describe "POST #edit_later" do
    context "正常系：ログインユーザーが既に募集を作成している" do
      before do
        @recruit_later.user = @user
        @recruit_later.save
        post recruitments_later_edit_path
      end
      it "edit_laterアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "edit_laterアクションにリクエストするとレスポンスにログインユーザー情報が含まれる" do
        expect(response.body).to include(@recruit_later.user.name)
      end
      it "edit_laterアクションにリクエストするとレスポンスに募集情報が含まれる" do
        expect(response.body).to include(@recruit_later.close_condition_count.to_s)
      end
    end
    context "異常系：ログインユーザー募集を作成していない" do
      it "edit_laterアクションにリクエストするとリダイレクトされる" do
        post recruitments_later_edit_path
        expect(response.status).to eq 302
      end
    end
  end

  describe "POST #edit_now" do
    context "正常系：ログインユーザーが既に募集を作成している" do
      before do
        @recruit_now.user = @user
        @recruit_now.save
        post recruitments_now_edit_path
      end
      it "edit_nowアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "edit_nowアクションにリクエストするとレスポンスにログインユーザー情報が含まれる" do
        expect(response.body).to include(@recruit_now.user.name)
      end
      it "edit_nowアクションにリクエストするとレスポンスに募集情報が含まれる" do
        expect(response.body).to include(@recruit_now.close_condition_count.to_s)
      end
    end
    context "異常系：ログインユーザー募集を作成していない" do
      it "edit_nowアクションにリクエストするとリダイレクトされる" do
        post recruitments_now_edit_path
        expect(response.status).to eq 302
      end
    end  
  end

  describe "POST #update_later" do
    context "正常系：ログインユーザーが既に募集を作成している" do
      before do
        @recruit_later.user = @user
        @recruit_later.save
        post recruitments_later_update_path, params: {recruit_later:{
          start_at_hour_top: @recruit_later.start_at_hour_top,
          start_at_minute_top: @recruit_later.start_at_minute_top,
          start_at_hour_bottom: @recruit_later.start_at_hour_bottom,
          start_at_minute_bottom: @recruit_later.start_at_minute_bottom,
          end_at_hour_top: @recruit_later.end_at_hour_top,
          end_at_minute_top: @recruit_later.end_at_minute_top,
          end_at_hour_bottom: @recruit_later.end_at_hour_bottom,
          end_at_minute_bottom: @recruit_later.end_at_minute_bottom,
          place: @recruit_later.place,
          message: @recruit_later.message,
          close_condition_count: @recruit_later.close_condition_count
        }}
      end
      it "update_laterアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "update_laterアクションにリクエストするとレスポンスに募集情報が含まれる" do
        expect(response.body).to include(@recruit_later.close_condition_count.to_s)
      end
      it "update_laterアクションにリクエストするとレスポンスに「これから」の募集情報が含まれる" do
        expect(response.body).to include(@recruit_later.start_at_hour_top.to_s)
      end
      it "update_laterアクションにリクエストするとレスポンスに募集が終了しているかの情報が含まれる" do
        expect(response.body).to include(Recruit.find_by(@user_id).close?.to_s)
      end
      it "update_laterアクションにリクエストするとレスポンスにflash情報が含まれる" do
        expect(response.body).to include("flash")
      end
    end
    context "異常系：ログインユーザー募集を作成していない" do
      it "update_laterアクションにリクエストするとリダイレクトされる" do
        post recruitments_later_update_path, params: {recruit_later:{
          start_at_hour_top: @recruit_later.start_at_hour_top,
          start_at_minute_top: @recruit_later.start_at_minute_top,
          start_at_hour_bottom: @recruit_later.start_at_hour_bottom,
          start_at_minute_bottom: @recruit_later.start_at_minute_bottom,
          end_at_hour_top: @recruit_later.end_at_hour_top,
          end_at_minute_top: @recruit_later.end_at_minute_top,
          end_at_hour_bottom: @recruit_later.end_at_hour_bottom,
          end_at_minute_bottom: @recruit_later.end_at_minute_bottom,
          place: @recruit_later.place,
          message: @recruit_later.message,
          close_condition_count: @recruit_later.close_condition_count
        }}
        expect(response.status).to eq 302
      end
    end
  end

  describe "POST #update_now" do
    context "正常系：ログインユーザーが既に募集を作成している" do
      before do
        @recruit_now.user = @user
        @recruit_now.save
        post recruitments_now_update_path, params: {recruit_now:{
          member_count: @recruit_now.member_count,
          end_at_hour_top: @recruit_now.end_at_hour_top,
          end_at_minute_top: @recruit_now.end_at_minute_top,
          end_at_hour_bottom: @recruit_now.end_at_hour_bottom,
          end_at_minute_bottom: @recruit_now.end_at_minute_bottom,
          place: @recruit_now.place,
          message: @recruit_now.message,
          close_condition_count: @recruit_now.close_condition_count
        }}
      end
      it "update_nowアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "update_nowアクションにリクエストするとレスポンスに募集情報が含まれる" do
        expect(response.body).to include(@recruit_now.close_condition_count.to_s)
      end
      it "update_nowアクションにリクエストするとレスポンスに「これから」の募集情報が含まれる" do
        expect(response.body).to include(@recruit_now.member_count.to_s)
      end
      it "update_nowアクションにリクエストするとレスポンスに募集が終了しているかの情報が含まれる" do
        expect(response.body).to include(Recruit.find_by(@user_id).close?.to_s)
      end
      it "update_nowアクションにリクエストするとレスポンスにflash情報が含まれる" do
        expect(response.body).to include("flash")
      end
    end
    context "異常系：ログインユーザー募集を作成していない" do
      it "update_nowアクションにリクエストするとリダイレクトされる" do
        post recruitments_now_update_path, params: {recruit_now:{
          member_count: @recruit_now.member_count,
          end_at_hour_top: @recruit_now.end_at_hour_top,
          end_at_minute_top: @recruit_now.end_at_minute_top,
          end_at_hour_bottom: @recruit_now.end_at_hour_bottom,
          end_at_minute_bottom: @recruit_now.end_at_minute_bottom,
          place: @recruit_now.place,
          message: @recruit_now.message,
          close_condition_count: @recruit_now.close_condition_count
        }}
        expect(response.status).to eq 302
      end
    end
  end

  describe "GET #show" do
    context "対象の募集が存在しない場合" do
      it "showアクションにリクエストするとリダイレクトされる" do
        get recruitment_path(1)
        expect(response.status).to eq 302
      end
    end
    
    context "対象の募集を作成も参加もしていない場合" do
      it "showアクションにリクエストするとリダイレクトされる" do
        @recruit_later.user = @other_user
        @recruit_later.save
        @recruit = Recruit.find_by(user_id: @other_user.id)
        get recruitment_path(@recruit)
        expect(response.status).to eq 302
      end
    end
    
    context "対象の募集が自分の募集の場合" do
      before do
        @recruit_later.user = @user
        @recruit_later.save
        @recruit = Recruit.find_by(user_id: @user.id)
      end
      it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
        get recruitment_path(@recruit)
        expect(response.status).to eq 200
      end
      it "showアクションにリクエストするとレスポンスにページ名が存在する" do
        get recruitment_path(@recruit)
        expect(response.body).to include("マイ募集ルーム") 
      end
      it "showアクションにリクエストするとレスポンスに募集人数が存在する" do
        get recruitment_path(@recruit)
        expect(response.body).to include(@recruit.close_condition_count.to_s) 
      end
      it "showアクションにリクエストするとメッセージがあれば返ってくる" do
        message = FactoryBot.build(:message)
        message.sender = @user
        message.room = @recruit
        message.save
        get recruitment_path(@recruit)
        expect(response.body).to include(message.text) 
      end
    end
    
    context "対象の募集が自分の参加している募集の場合" do
      before do
        @recruit_later.user = @other_user
        @recruit_later.save
        @recruit = Recruit.find_by(user_id: @other_user.id)
        @entry = FactoryBot.build(:entry)
        @entry.user = @user
        @entry.recruit = @recruit
        @entry.save
        get recruitment_path(@recruit)
      end
      it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200
      end
      it "showアクションにリクエストするとレスポンスにページ名が存在する" do
        expect(response.body).to include("参加中のルーム") 
      end
      it "showアクションにリクエストするとレスポンスに募集人数が存在する" do
        expect(response.body).to include(@recruit.close_condition_count.to_s) 
      end
      it "showアクションにリクエストするとメッセージがあれば返ってくる" do
        message = FactoryBot.build(:message)
        message.sender = @user
        message.room = @recruit
        message.save
        get recruitment_path(@recruit)
        expect(response.body).to include(message.text) 
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @recruit_later.user = @user
    end
    context "正常系：自分の募集が存在する場合" do
      it "destroyアクションにリクエストするとリダイレクトされる" do
        @recruit_later.save
        delete recruitments_destroy_path
        expect(response.status).to eq 302
      end
      
    end
    context "異常系：自分の募集が存在しない場合" do
      it "destroyアクションにリクエストするとリダイレクトされる" do
        delete recruitments_destroy_path
        expect(response.status).to eq 302
      end
    end
  end

  describe "POST #close" do
    before do
      @recruit_later.user = @user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @user.id)
      post recruitments_close_path
    end
    it "closeアクションにリクエストすると正常にレスポンスが返ってくる" do
      expect(response.status).to eq 200 
    end
    it "closeアクションにリクエストするとレスポンスに募集終了の真偽値が存在する" do
      expect(response.body).to include("close_flag", "true") 
    end
    it "closeアクションにリクエストするとレスポンスにflashが存在する" do
      expect(response.body).to include("flash") 
    end
  end

  describe "POST #restart" do
    before do
      @recruit_later.user = @user
      @recruit_later.save
      @recruit = Recruit.find_by(user_id: @user.id)
      @recruit.update(close_flag: 1)
      post recruitments_restart_path
    end
    it "restartアクションにリクエストすると正常にレスポンスが返ってくる" do
      expect(response.status).to eq 200 
    end
    it "restartアクションにリクエストするとレスポンスに募集終了の真偽値が存在する" do
      expect(response.body).to include("close_flag", "false") 
    end
    it "restartアクションにリクエストするとレスポンスにflashが存在する" do
      expect(response.body).to include("flash") 
    end
  end

  describe "GET #confirmation_later" do
    context "正常系：対象の募集が存在する場合" do
      before do
        @recruit_later.user = @user
        @recruit_later.save
        @recruit = Recruit.find_by(user_id: @user.id)
        get recruitment_confirmation_later_path(@recruit)
      end
      it "confirmation_laterアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "confirmation_laterアクションにリクエストすると募集情報が存在する" do
        expect(response.body).to include(@recruit.close_condition_count.to_s) 
      end
      it "confirmation_laterアクションにリクエストすると「これから」の募集内容が存在する" do
        expect(response.body).to include(@recruit.later.start_at_hour_bottom.to_s) 
      end
      it "confirmation_laterアクションにリクエストすると募集したユーザーの情報が存在する" do
        expect(response.body).to include(@recruit.user.name) 
      end
    end
    
    context "異常系：対象の募集が存在しない場合" do
      it "confirmation_laterアクションにリクエストするとリダイレクトされる" do
        get recruitment_confirmation_later_path(1)
        expect(response.status).to eq 302 
      end
    end
  end

  describe "GET #confirmation_now" do
    context "正常系：対象の募集が存在する場合" do
      before do
        @recruit_now.user = @user
        @recruit_now.save
        @recruit = Recruit.find_by(user_id: @user.id)
        get recruitment_confirmation_now_path(@recruit)
      end
      it "confirmation_nowアクションにリクエストすると正常にレスポンスが返ってくる" do
        expect(response.status).to eq 200 
      end
      it "confirmation_nowアクションにリクエストすると募集情報が存在する" do
        expect(response.body).to include(@recruit.close_condition_count.to_s) 
      end
      it "confirmation_nowアクションにリクエストすると「これから」の募集内容が存在する" do
        expect(response.body).to include(@recruit.now.member_count.to_s) 
      end
      it "confirmation_nowアクションにリクエストすると募集したユーザーの情報が存在する" do
        expect(response.body).to include(@recruit.user.name) 
      end
    end
    
    context "異常系：対象の募集が存在しない場合" do
      it "confirmation_nowアクションにリクエストするとリダイレクトされる" do
        get recruitment_confirmation_now_path(1)
        expect(response.status).to eq 302 
      end
    end
  end
end
