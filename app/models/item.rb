class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :name, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9_999_999 }
  validates :description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1 }
  validates :condition_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_fee_burden_id, presence: true, numericality: { other_than: 1 }
  validates :prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_day_id, presence: true, numericality: { other_than: 1 }
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image
  has_one :order
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day
end
