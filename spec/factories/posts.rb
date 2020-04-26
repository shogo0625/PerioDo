FactoryBot.define do
  factory :post do
    content { "Hello World" }
    association :user
  end
end
