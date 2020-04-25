require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  it "User情報・本文があれば有効" do
  	expect(@post).to be_valid
  end

  it "User情報がなければ無効" do
  	post = Post.create(content: "Hello World")
  	expect(post).to be_invalid
  end

  it "本文がなければ無効" do
  	@post.content = nil
  	@post.valid?
  	expect(@post.errors[:content]).to include("を入力してください")
  end

  it "本文が161文字以上で無効" do
  	@post.content = 'あ' * 161
  	@post.valid?
  	expect(@post.errors[:content]).to include("は160文字以内で入力してください")
  end

end
