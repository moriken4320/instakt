require 'rails_helper'

RSpec.describe Now, type: :model do
  before do
    @now = FactoryBot.build(:now)
  end

  context "「いま」の募集内容が保存可能" do
    it "recruitが正常に存在すると保存できる" do
      expect(@now).to be_valid 
    end
  end

  context "「いま」の募集内容が保存不可" do
    it "recruitが正常に存在しないと保存できない" do
      @now.recruit = nil
      @now.valid?
      expect(@now.errors.full_messages).to include("Recruit must exist") 
    end
  end
end
