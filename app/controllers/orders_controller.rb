class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root, only: [:index, :create]

  def index
    @order_shipping = OrderShipping.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY'] 
  end

  def create
    @order_shipping = OrderShipping.new(order_shipping_params)
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path, notice: "購入が完了しました"
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY'] 
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_shipping_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] 
    Payjp::Charge.create(
      amount: @item.price,
      card: order_shipping_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root
    if @item.user.id == current_user.id || @item.order.present?
      redirect_to root_path
    end
  end
end
