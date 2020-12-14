class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchants = Merchant.search(search_params)
    render json: MerchantSerializer.new(merchants)
  end

  private

  def search_params
    params.permit(params.keys.first, params.values.first)
  end
end
