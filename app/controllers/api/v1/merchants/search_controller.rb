class Api::V1::Merchants::SearchController < ApplicationController

  def index
    unless search_attribute && !search_value.blank?
      check_params(['search'])
    else
      merchants = Merchant.search(search_attribute, search_value)
      render json: MerchantSerializer.new(merchants)
    end
  end

  def show
    unless search_attribute && !search_value.blank?
      check_params(['search'])
    else
      merchant = Merchant.search(search_attribute, search_value).first
      render json: MerchantSerializer.new(merchant)
    end
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end

  def search_attribute
    search_params.keys[0]
  end

  def search_value
    search_params[search_attribute]
  end
end
