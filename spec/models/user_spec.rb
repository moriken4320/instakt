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
    it "passwordが空だと保存されない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank") 
    end
    it 'passwordが5文字以下だと保存できない' do
      @user.password = 'aaaaa'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it "passwordとpassword_confirmationが一致していなければ保存できない" do
      @user.password_confirmation = 'bbbbbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
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
  end
  
end
