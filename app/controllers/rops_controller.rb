class RopsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_params
  before_action :check_available, only: [:index]
  before_action :anlyze_user, only: [:index]

  def index
    @rop_address = RopAddress.new
  end

  def create
    @rop_address = RopAddress.new(rop_params)
    if @rop_address.valid?
      pay_item
      @rop_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def rop_params
    params.require(:rop_address).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :tel).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item_params
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    price = Item.find(params[:item_id]).price
    Payjp::Charge.create(
      amount: price,
      card: rop_params[:token],
      currency: 'jpy'
    )
  end

  def check_available
    redirect_to root_path if @item.rop.present?
  end

  def anlyze_user
    redirect_to root_path if @item.user == current_user
  end
end
