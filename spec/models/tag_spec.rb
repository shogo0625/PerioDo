require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = Tag.new(name: "StayHome")
  end

  it "nameがあれば有効" do
    expect(@tag).to be_valid
  end

  it "nameがないと無効" do
    @tag.name = nil
    @tag.valid?
    expect(@tag.errors[:name]).to include("を入力してください")
  end

  it "nameが51文字以上で無効" do
    @tag.name = 'あ' * 51
    @tag.valid?
    expect(@tag.errors[:name]).to include("は50文字以内で入力してください")
  end
end
