require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  context "メッセージが保存可能" do
    it "全ての値が正常に設定されていれば保存される" do
      expect(@message).to be_valid 
    end
    it "imageが添付されていなくても、textが存在すれば保存できる" do
      @message.image = nil
      expect(@message).to be_valid 
    end
    it "textが存在しなくても、imageが添付されていれば保存できる" do
      @message.text = nil
      expect(@message).to be_valid 
    end
  end
  
  
  context "メッセージが保存不可" do
    it "textとimageが空だと保存されない" do
      @message.text = nil
      @message.image = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Text can't be blank") 
    end
    it "senderが存在しないと保存されない" do
      @message.sender = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Sender must exist") 
    end
    it "roomが存在しないと保存されない" do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Room must exist") 
    end
  end
end
