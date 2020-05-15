FactoryBot.define do
  factory :routine do
    title { "MyString" }
    comment { "MyText" }
    user_id { 1 }
    status { 1 }
  end
end
