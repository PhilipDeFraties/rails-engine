class Api::V1::Merchants::BizintelController < ApplicationController

  def most_revenue
    unless params[:quantity] && !params[:quantity].empty?
      check_params(['quantity'])
    else
      merchants = Merchant.most_revenue(params[:quantity])
      render json: MerchantSerializer.new(merchants)
    end
  end

  def most_items
    unless params[:quantity] && !params[:quantity].empty?
      check_params(['quantity'])
    else
      merchants = Merchant.most_items_sold(params[:quantity])
      render json: MerchantSerializer.new(merchants)
    end
  end

  def revenue
    revenue = Merchant.revenue(params[:id])
    render json: RevenueSerializer.revenue(revenue)
  end

  def revenue_across_dates
    errors = []
    errors << 'start' unless params[:start] && !params[:start].empty?
    errors << 'end' unless params[:end] && !params[:end].empty?
    unless errors.empty?
      check_params(errors)
    else
      render json: RevenueSerializer.revenue(InvoiceItem.revenue_across_dates(params[:start], params[:end]))
    end
  end

private

  def check_params(params)
    render json: JSON.generate(
      {
        error: 'missing parameter',
        errors: params.map { |param| "#{param} parameter required in search request" },
        status: :bad_request
      }
    )
  end
end
