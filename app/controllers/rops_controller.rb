class RopsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @rop_address = RopAddress.new
  end

  def create

  end
end
