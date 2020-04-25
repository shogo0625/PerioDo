require 'rails_helper'

RSpec.describe Task, type: :model do
	before do
		@task = FactoryBot.build(:task)
	end

	it "User情報・本文があれば有効" do
		expect(@task).to be_valid
	end

  it "User情報がなければ無効" do
    task = Task.create(content: "Hello Rails")
    expect(task).to be_invalid
  end

	it "本文がないと無効" do
		@task.content = nil
		@task.valid?
		expect(@task.errors[:content]).to include("を入力してください")
	end

	it "本文が51文字以上で無効" do
		@task.content = 'あ' * 51
		@task.valid?
		expect(@task.errors[:content]).to include("は50文字以内で入力してください")
	end
end
