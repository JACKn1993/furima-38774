class RopsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_params
  
  def index
    @rop_address = RopAddress.new
  end

  def create

    @rop_address = RopAddress.new(rop_params)
    if @rop_address.valid?
      @rop_address.save
      redirect_to root_path
    else
      render :index
    end
  end


  private
  def rop_params
    params.require(:rop_address).permit( :postal_code, :prefecture_id, :municipality, :address, :building_name, :tel ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item_params
    @item = Item.find(params[:item_id])
  end
end
