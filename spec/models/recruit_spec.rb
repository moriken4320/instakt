require 'rails_helper'

RSpec.describe Recruit, type: :model do
  before do
    @recruit = FactoryBot.build(:recruit)
  end

  context "募集情報が保存可能" do
    it "userが正常に存在すると保存できる" do
      expect(@recruit).to be_valid 
    end
  end

  context "募集情報が保存不可" do
    it "userが正常に存在しないと保存できない" do
      @recruit.user = nil
      @recruit.valid?
      expect(@recruit.errors.full_messages).to include("User must exist") 
    end
  end
  
end
