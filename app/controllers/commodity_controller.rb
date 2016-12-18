class CommodityController < ApplicationController

  def add
    Commodity.create({ name: params[:id] })

    redirect_to controller: :history, action: :sequence
  end
end
