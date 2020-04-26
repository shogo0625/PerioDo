FactoryBot.define do
  factory :post_comment do
    comment { "Hello Rspec" }
    association :user
    association :post
  end
end
