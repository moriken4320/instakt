require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context "ユーザー情報が保存可能" do
    it "全ての値が正常に設定されていれば保存される" do
      expect(@user).to be_valid 
    end
  end
  
  context "ユーザー情報が保存不可" do
    it "nameが空だと保存されない" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank") 
    end
    it "nameが10文字以上だと保存されない" do
      @user.name = "aaaaaaaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name is too long (maximum is 10 characters)") 
    end
    it "emailが空だと保存されない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank") 
    end
    it 'emailに@が含まれていないと保存できない' do
      @user.email = 'aaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it "providerが空だと保存されない" do
      @user.provider = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Provider can't be blank") 
    end
    it "uidが空だと保存されない" do
      @user.uid = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Uid can't be blank") 
    end
    it "imageが空だと保存されない" do
      @user.image = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Image can't be blank") 
    end
  end
  
end
