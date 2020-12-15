class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.search(params.keys.first, params.values.first)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.search(params.keys.first, params.values.first).first
    render json: ItemSerializer.new(item)
  end

  private

  def search_params
    params.permit(params.keys.first, params.values.first)
  end
end
