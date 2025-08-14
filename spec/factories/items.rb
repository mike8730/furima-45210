FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: Category.all.size) }
    condition_id { Faker::Number.between(from: 2, to: Condition.all.size) }
    shipping_fee_burden_id { Faker::Number.between(from: 2, to: ShippingFeeBurden.all.size) }
    prefecture_id { Faker::Number.between(from: 2, to: Prefecture.all.size) }
    shipping_day_id { Faker::Number.between(from: 2, to: ShippingDay.all.size) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end