require 'rails_helper'

RSpec.describe RecruitNow, type: :model do
  before do
    @recruit_now = FactoryBot.build(:recruit_now)
  end

  context "「いま」の募集内容と募集情報が保存可能" do
    it "値が全て正常に存在すると保存できる" do
      expect(@recruit_now).to be_valid 
    end
    it "placeが空でも保存できる" do
      @recruit_now.place = ""
      expect(@recruit_now).to be_valid 
    end
    it "messageが空でも保存できる" do
      @recruit_now.message = ""
      expect(@recruit_now).to be_valid 
    end
  end

  context "「いま」の募集内容と募集情報が保存不可" do
    it "member_countが整数以外だと保存できない" do
      @recruit_now.member_count = 0.1
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Member count must be an integer") 
    end
    it "member_countが1より小さいと保存できない" do
      @recruit_now.member_count = 0
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Member count must be greater than or equal to 1") 
    end
    it "member_countが15より大きいと保存できない" do
      @recruit_now.member_count = 16
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Member count must be less than or equal to 15") 
    end
    
    it "end_at_hour_topが整数以外だと保存できない" do
      @recruit_now.end_at_hour_top = 0.1
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("End at hour top must be an integer") 
    end
    it "end_at_hour_topが0より小さいと保存できない" do
      @recruit_now.end_at_hour_top = -1
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("End at hour top must be greater than or equal to 0") 
    end
    it "end_at_hour_topが23より大きいと保存できない" do
      @recruit_now.end_at_hour_top = 24
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("End at hour top must be less than or equal to 23") 
    end

    it "end_at_minute_topが整数以外だと保存できない" do
      @recruit_now.end_at_minute_top = 0.1
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("End at minute top must be an integer") 
    end
    it "end_at_minute_topが0より小さいと保存できない" do
      @recruit_now.end_at_minute_top = -1
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("End at minute top must be greater than or equal to 0") 
    end
    it "end_at_minute_topが59より大きいと保存できない" do
      @recruit_now.end_at_minute_top = 60
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("End at minute top must be less than or equal to 59") 
    end

    it "placeが20文字より大きいと保存できない" do
      @recruit_now.place = "aaaaaaaaaaaaaaaaaaaaa"
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Place is too long (maximum is 20 characters)") 
    end
    
    it "messageが20文字より大きいと保存できない" do
      @recruit_now.message = "aaaaaaaaaaaaaaaaaaaaa"
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Message is too long (maximum is 20 characters)") 
    end

    it "close_condition_countが整数以外だと保存できない" do
      @recruit_now.close_condition_count = 0.1
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Close condition count must be an integer") 
    end
    it "close_condition_countが1より小さいと保存できない" do
      @recruit_now.close_condition_count = 0
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Close condition count must be greater than or equal to 1") 
    end
    it "close_condition_countが15より大きいと保存できない" do
      @recruit_now.close_condition_count = 16
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("Close condition count must be less than or equal to 15") 
    end
    
    it "userが存在しないと保存できない" do
      @recruit_now.user = nil
      @recruit_now.valid?
      expect(@recruit_now.errors.full_messages).to include("User can't be blank")
    end
    
  end
end