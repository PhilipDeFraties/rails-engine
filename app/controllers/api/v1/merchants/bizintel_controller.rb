class Api::V1::Merchants::BizintelController < ApplicationController

  def most_revenue
    merchants = Merchant.rank_by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def most_items
    merchants = Merchant.rank_by_items_sold(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

end
