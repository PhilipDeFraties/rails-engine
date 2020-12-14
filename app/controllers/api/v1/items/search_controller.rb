class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.search(search_params)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.search(search_params).first
    render json: ItemSerializer.new(item)
  end

  private

  def search_params
    params.permit(params.keys.first, params.values.first)
  end
end
