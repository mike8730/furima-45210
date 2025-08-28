class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_root, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :condition_id, :shipping_fee_burden_id,
                                 :prefecture_id, :shipping_day_id, :image).merge(user_id: current_user.id)
  end

  def move_to_root
    @item = Item.find(params[:id])
    if @item.order.present?
      redirect_to root_path
    end
  end
end
