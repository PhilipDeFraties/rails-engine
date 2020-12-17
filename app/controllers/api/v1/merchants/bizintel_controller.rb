class Api::V1::Merchants::BizintelController < ApplicationController

  def most_revenue
    merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def most_items
    merchants = Merchant.most_items_sold(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def revenue
    revenue = Merchant.revenue(params[:id])
    render json: RevenueSerializer.revenue(revenue)
  end

  def revenue_across_dates
    revenue = InvoiceItem.revenue_accross_dates(params[:start], params[:end])
    render json: RevenueSerializer.revenue(revenue)
  end

end
