require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "新規ユーザーが会員登録をする" do
    user = FactoryBot.build(:user)

    visit root_path
    click_link "新規登録"
    fill_in "名前", with: user.name
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    fill_in "パスワード確認", with: user.password
    click_button "登録する"

    expect(page).to have_content "アカウント登録が完了しました。"
  end

  scenario "既存ユーザーがログインする" do
    user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect(page).to have_content "ログインしました。"
  end

  scenario "既存ユーザーがログアウトする" do
    user = FactoryBot.create(:user)
    sign_in user
    visit root_path
    find('#mypage').click
    click_link "登録情報"
    click_link "ログアウト"

    expect(page).to have_content "ログアウトしました。"
  end

  scenario "既存ユーザーが退会する" do
    user = FactoryBot.create(:user)
    sign_in user
    visit root_path
    find('#mypage').click
    click_link "登録情報"
    click_link "退会する"

    expect(page).to have_content "アカウントを削除しました。"
  end

  scenario "既存ユーザーが登録情報を更新する" do
    user = FactoryBot.create(:user)
    sign_in user
    visit root_path
    find('#mypage').click
    click_link "登録情報"
    user.introduction = "よろしくお願いします"
    fill_in "自己紹介", with: user.introduction
    click_button "変更する"

    expect(page).to have_content "ユーザー情報を更新しました。"
    expect(page).to have_content user.introduction
  end
end
