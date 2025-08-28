require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = Order.create(user_id: @user.id, item_id: @item.id)
    @shipping_address = FactoryBot.build(:shipping_address, order_id: @order.id)
  end

  describe '配送先住所の保存' do
    context '保存できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@shipping_address).to be_valid
      end

      it '電話番号が10桁でも保存できる' do
        @shipping_address.phone_number = '0312345678'
        expect(@shipping_address).to be_valid
      end

      it '電話番号が11桁でも保存できる' do
        @shipping_address.phone_number = '09012345678'
        expect(@shipping_address).to be_valid
      end

      it '郵便番号が「3桁-4桁」の半角文字列であれば保存できる' do
        @shipping_address.postal_code = '123-4567'
        expect(@shipping_address).to be_valid
      end

      it '建物名が空でも保存できる' do
        @shipping_address.building = ''
        expect(@shipping_address).to be_valid
      end
    end

    context '保存できないとき' do
      it '郵便番号が空では保存できない' do
        @shipping_address.postal_code = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンが含まれていないと保存できない' do
        @shipping_address.postal_code = '1234567'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '郵便番号が全角数字だと保存できない' do
        @shipping_address.postal_code = '１２３-４５６７'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '都道府県が1（--）では保存できない' do
        @shipping_address.prefecture_id = 1
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it '市区町村が空では保存できない' do
        @shipping_address.city = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できない' do
        @shipping_address.address = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では保存できない' do
        @shipping_address.phone_number = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では保存できない' do
        @shipping_address.phone_number = '090123456'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が12桁以上では保存できない' do
        @shipping_address.phone_number = '090123456789'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が全角数字だと保存できない' do
        @shipping_address.phone_number = '０９０１２３４５６７８'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'orderと紐付いていなければ保存できない' do
        @shipping_address.order = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Order must exist")
      end
    end
  end
end