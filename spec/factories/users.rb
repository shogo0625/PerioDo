FactoryBot.define do
  factory :user do
    name { "Taro" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "aaaaaa" }
  end
end
