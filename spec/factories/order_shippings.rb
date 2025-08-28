FactoryBot.define do
  factory :order_shipping do
    postal_code    { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id  { Faker::Number.between(from: 2, to: 47) } 
    city           { Faker::Address.city }
    address        { Faker::Address.street_address }
    building       { Faker::Address.secondary_address }
    phone_number   { Faker::Number.number(digits: 11) }
    token          { "tok_#{SecureRandom.hex(24)}" }
  end
end