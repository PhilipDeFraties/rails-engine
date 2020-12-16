class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.search(search_attribute, search_value)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.search(search_attribute, search_value).first
    render json: ItemSerializer.new(item)
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

  def search_attribute
    search_params.keys[0]
  end

  def search_value
    search_params[search_attribute]
  end
end
