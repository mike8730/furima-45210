class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :condition
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :shipping_fee_burden
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :Prefecture
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :shipping_day
end
