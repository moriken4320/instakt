require 'rails_helper'

RSpec.describe Entry, type: :model do
  before do
    @entry = FactoryBot.build(:entry)
  end

  context "参加情報が保存可能" do
    it "userとrecruitが正常に存在すると保存できる" do
      expect(@entry).to be_valid 
    end
  end

  context "参加情報が保存不可" do
    it "userが正常に存在しないと保存できない" do
      @entry.user = nil
      @entry.valid?
      expect(@entry.errors.full_messages).to include("User must exist") 
    end
    it "recruitが正常に存在しないと保存できない" do
      @entry.recruit = nil
      @entry.valid?
      expect(@entry.errors.full_messages).to include("Recruit must exist") 
    end
  end
end
