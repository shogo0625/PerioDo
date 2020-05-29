require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  scenario "ユーザーが新規投稿する" do
    user = FactoryBot.create(:user)
    sign_in user
    visit root_path
    find('#mypage').click

    post = FactoryBot.build(:post)
    expect do
      click_link "ヒトコト投稿"
      find('#input-text').set(post.content)
      click_button "投稿する"

      expect(page).to have_content "あなたのヒトコトが投稿されました。"
      expect(page).to have_content post.content
    end.to change(user.posts, :count).by(1)
  end

  scenario "ユーザーが既存の投稿を編集する" do
    user = FactoryBot.create(:user)
    sign_in user
    post = user.posts.create(content: "編集前の本文です")
    visit post_path(post)

    click_link "編集"
    post.content = "本文を編集します"
    find('#input-text').set(post.content)
    click_button "投稿する"

    expect(page).to have_content "あなたのヒトコトが更新されました。"
    expect(page).to have_content post.content
  end

  scenario "ユーザーが既存の投稿を削除する" do
    user = FactoryBot.create(:user)
    sign_in user
    post = user.posts.create(content: "この投稿を削除します")
    visit post_path(post)

    click_link "削除"

    expect(page).to have_content "ヒトコトを削除しました。"
  end

  scenario "新規投稿後、タグが保存される" do
    user = FactoryBot.create(:user)
    sign_in user
    visit root_path
    find('#mypage').click

    post = FactoryBot.build(:post)
    click_link "ヒトコト投稿"
    fill_in "input-text", with: "うちで過ごそう #StayHome"
    click_button "投稿する"

    tag = Tag.find_by(name: "StayHome")
    expect(page).to have_content "あなたのヒトコトが投稿されました。"
    expect(tag.name).to eq("StayHome")
  end

  scenario "投稿編集後、タグ名も変更される" do
    user = FactoryBot.create(:user)
    sign_in user
    post = user.posts.create(content: "編集前 #BeforeUpdate")
    visit post_path(post)

    click_link "編集"
    post.content = "編集後 #AfterUpdate"
    fill_in "input-text", with: post.content
    click_button "投稿する"

    tag = Tag.find_by(name: "AfterUpdate")
    expect(page).to have_content "あなたのヒトコトが更新されました。"
    expect(tag.name).to eq("AfterUpdate")
  end
end
