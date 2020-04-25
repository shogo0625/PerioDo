require 'rails_helper'

RSpec.describe PostComment, type: :model do
	before do
		@post_comment = FactoryBot.build(:post_comment)
	end

	it "User情報・Post情報・本文があれば有効" do
		expect(@post_comment).to be_valid
	end

  it "User情報がなければ無効" do
    post_comment = PostComment.create(post: FactoryBot.create(:post), comment: "Hello Rspec")
    expect(post_comment).to be_invalid
  end

  it "Post情報がなければ無効" do
    post_comment = PostComment.create(user: FactoryBot.create(:user), comment: "Hello Rspec")
    expect(post_comment).to be_invalid
  end

  it "本文がなければ無効" do
  	@post_comment.comment = nil
  	@post_comment.valid?
  	expect(@post_comment.errors[:comment]).to include("を入力してください")
  end

  it "本文が101文字以上で無効" do
  	@post_comment.comment = 'あ' * 101
  	@post_comment.valid?
  	expect(@post_comment.errors[:comment]).to include("は100文字以内で入力してください")
  end
end
