require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  it "フォロワーが別のユーザーをフォローできる" do
    relationship = Relationship.new(follower_id: @user1.id, followed_id: @user2.id)
    expect(relationship).to be_valid
  end

  it "同じユーザーを2度フォローできない（ユニークである）" do
    expect do
      Relationship.create(follower_id: @user1.id, followed_id: @user2.id)
      Relationship.create(follower_id: @user1.id, followed_id: @user2.id)
    end.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
