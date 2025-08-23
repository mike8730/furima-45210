class ShippingAddress < ApplicationRecord
  belongs_to :order
  belongs_to_active_hash :prefecture

  with_options presence: true do           
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end
end
