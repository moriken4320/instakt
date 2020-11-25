require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @relationship = FactoryBot.build(:relationship)
  end

  context "リレーション情報が保存可能" do
    it "followerとfollowingとしてuserが正常に存在すると保存できる" do
      expect(@relationship).to be_valid 
    end
    
  end

  context "リレーション情報が保存不可" do
    it "followerとしてuserが存在しないと保存されない" do
      @relationship.follower = nil
      @relationship.valid?
      expect(@relationship.errors.full_messages).to include("Follower must exist") 
    end
    it "followingとしてuserが存在しないと保存されない" do
      @relationship.following = nil
      @relationship.valid?
      expect(@relationship.errors.full_messages).to include("Following must exist") 
    end
    
  end
  
  
end
