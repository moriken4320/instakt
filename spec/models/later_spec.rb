require 'rails_helper'

RSpec.describe Later, type: :model do
  before do
    @later = FactoryBot.build(:later)
  end

  context "「これから」の募集内容が保存可能" do
    it "recruitが正常に存在すると保存できる" do
      expect(@later).to be_valid 
    end
  end

  context "「これから」の募集内容が保存不可" do
    it "recruitが正常に存在しないと保存できない" do
      @later.recruit = nil
      @later.valid?
      expect(@later.errors.full_messages).to include("Recruit must exist") 
    end
  end
end
