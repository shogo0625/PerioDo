FactoryBot.define do
  factory :premade_task do
    content { "MyText" }
    time { "2020-05-15 02:07:41" }
    user_id { 1 }
  end
end
