FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    description { Faker::Lorem.sentences(number: 1) }
    unit_price { Faker::Number.within(range: 1..99999) }
    association :merchant
  end
end
