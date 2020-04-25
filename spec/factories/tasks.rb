FactoryBot.define do
  factory :task do
    content { "Learn Ruby" }
    association :user
  end
end
