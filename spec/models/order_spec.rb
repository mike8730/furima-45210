require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '保存できるとき' do
    it 'ユーザーと商品が存在すれば保存できる' do
      expect(@order).to be_valid
    end
  end

  context '保存できないとき' do
    it 'ユーザーが存在しない場合は保存できない' do
      @order.user = nil
      expect(@order).not_to be_valid
    end

    it '商品が存在しない場合は保存できない' do
      @order.item = nil
      expect(@order).not_to be_valid
    end
  end
end