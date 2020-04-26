require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it "名前、メール、パスワードがあれば有効" do
    expect(@user).to be_valid
  end

  it "名前がなければ無効" do
    @user.name = nil
    @user.valid?
    expect(@user.errors[:name]).to include("が入力されていません。")
  end

  it "メールがなければ無効" do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("が入力されていません。")
  end

  it "パスワードがなければ無効" do
    @user.password = nil
    @user.valid?
    expect(@user.errors[:password]).to include("が入力されていません。")
  end

  it "メールアドレス重複で無効" do
    User.create(
      name: "Jiro",
      email: "tester@example.com",
      password: "aaaaaa",
    )
    @user.email = "tester@example.com"
    @user.valid?
    expect(@user.errors[:email]).to include("は既に使用されています。")
  end

  it "名前が31文字以上で無効" do
    @user.name = 'あ' * 31
    @user.valid?
    expect(@user.errors[:name]).to include("は30文字以内に設定して下さい。")
  end

  it "パスワードが6文字未満で無効" do
    @user.password = "aaaaa"
    @user.valid?
    expect(@user.errors[:password]).to include("は6文字以上に設定して下さい。")
  end

  it "自己紹介文が101文字以上で無効" do
    @user.introduction = 'あ' * 101
    @user.valid?
    expect(@user.errors[:introduction]).to include("は100文字以内で入力してください")
  end
end
