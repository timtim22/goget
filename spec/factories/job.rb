FactoryBot.define do
 factory :job, class: Job do
   pickup_address { Faker::Address.street_address }
   pick_lat { Faker::Number.number(digits: 2) }
   pick_lng { Faker::Number.number(digits: 2) }
   drop_address { Faker::Address.street_address }
   drop_lat { Faker::Number.number(digits: 2) }
   drop_lng { Faker::Number.number(digits: 2) }
 end
end
