require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: @user.id, item_id: @item.id)
  end

  describe '購入情報の保存' do
    context '保存できるとき' do
      it '全ての項目が正しく入力されていれば保存できる' do
        expect { @order_shipping.save }.to change { Order.count }.by(1).and change { ShippingAddress.count }.by(1)
      end

      it '電話番号が10桁でも保存できる' do
        @order_shipping.phone_number = '0312345678'
        expect(@order_shipping).to be_valid
      end

      it '電話番号が11桁でも保存できる' do
        @order_shipping.phone_number = '09012345678'
        expect(@order_shipping).to be_valid
      end

      it '郵便番号が「3桁-4桁」の半角文字列であれば保存できる' do
        @order_shipping.postal_code = '123-4567'
        expect(@order_shipping).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_shipping.building = ''
        expect { @order_shipping.save }.to change { Order.count }.by(1).and change { ShippingAddress.count }.by(1)
      end
    end

    context '保存できないとき' do
      it 'ユーザーIDが空では保存できない' do
        @order_shipping.user_id = nil
        expect(@order_shipping).to be_invalid
      end

      it '商品IDが空では保存できない' do
        @order_shipping.item_id = nil
        expect(@order_shipping).to be_invalid
      end

      it '郵便番号が空では保存できない' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンが含まれていないと保存できない' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it '郵便番号が全角数字だと保存できない' do
        @order_shipping.postal_code = '１２３-４５６７'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it '都道府県が未選択（id=1）の場合は保存できない' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it '市区町村が空では保存できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できない' do
        @order_shipping.address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では保存できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では保存できない' do
        @order_shipping.phone_number = '090123456'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が12桁以上では保存できない' do
        @order_shipping.phone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が全角数字だと保存できない' do
        @order_shipping.phone_number = '０９０１２３４５６７８'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it 'トークンが空では保存できない' do
        @order_shipping.token = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
