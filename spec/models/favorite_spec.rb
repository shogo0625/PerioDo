require 'rails_helper'

RSpec.describe Favorite, type: :model do
	it "User情報とPost情報があれば有効" do
		favorite = Favorite.new(user: FactoryBot.create(:user), post: FactoryBot.create(:post))
		expect(favorite).to be_valid
	end

	it "User情報がないと無効" do
		favorite = Favorite.new(post: FactoryBot.create(:post))
		expect(favorite).to be_invalid
	end

	it "Post情報がないと無効" do
		favorite = Favorite.new(user: FactoryBot.create(:user))
		expect(favorite).to be_invalid
	end

	it "User情報とPost情報の組み合わせがユニーク" do
		user = User.create(name: "Ichiro", email: "ichiro@example.com", password: "aaaaaa")
		post = FactoryBot.create(:post)
		first_favorite = Favorite.create(user: user, post: post)
		second_favorite = Favorite.new(user: user, post: post)
		expect(second_favorite).to be_invalid
	end

end
