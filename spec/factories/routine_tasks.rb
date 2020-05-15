FactoryBot.define do
  factory :routine_task do
    content { "MyText" }
    time { "2020-05-15 02:06:00" }
    routine_id { 1 }
  end
end
