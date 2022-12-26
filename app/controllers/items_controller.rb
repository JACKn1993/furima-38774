class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_item_params, only: [:show, :edit, :update]
  before_action :anlyze_user, only: :edit

  def index
    @items = Item.includes( :user ).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_id, :prefecture_id, :until_shipping_id, :price).merge(user_id: current_user.id)
  end

  def set_item_params
    @item = Item.find(params[:id])
  end

  def anlyze_user
    unless @item.user == current_user
      redirect_to root_path
    end
  end
end


