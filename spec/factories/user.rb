FactoryBot.define do
  factory :poster, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "usertest" }
    is_gogetter { false }
  end
end

FactoryBot.define do
  factory :gogetter, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "usertest" }
    is_gogetter { true }
  end
end