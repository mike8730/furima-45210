class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :name, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9_999_999 }
  validates :description, presence: true
  validates :user, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_fee_burden_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_day_id, presence: true
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_burden
  belongs_to :prefecture
  belongs_to :shipping_day
end

