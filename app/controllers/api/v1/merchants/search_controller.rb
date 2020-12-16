class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchants = Merchant.search(params.keys.first, params.values.first)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.search(params.keys.first, params.values.first).first
    render json: MerchantSerializer.new(merchant)
  end

  private

  def search_params
    params.permit(params.keys.first, params.values.first)
  end
end
