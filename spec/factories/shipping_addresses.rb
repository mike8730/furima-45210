FactoryBot.define do
  factory :shipping_address do
    postal_code   { Faker::Number.number(digits: 3).to_s + "-" + Faker::Number.number(digits: 4).to_s }
    prefecture_id { Faker::Number.between(from: 2, to: 47) } 
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { Faker::Address.secondary_address }
    phone_number  { Faker::Number.number(digits: [10, 11].sample) }
  end
end