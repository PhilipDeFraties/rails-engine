class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.search(search_params)
    render json: ItemSerializer.new(items)
  end

  private

  def search_params
    params.permit(params.keys.first, params.values.first)
  end
end
