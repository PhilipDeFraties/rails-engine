class Api::V1::Items::SearchController < ApplicationController

  def index
    unless search_attribute && !search_value.blank?
      check_params(['search'])
    else
      items = Item.search(search_attribute, search_value)
      render json: ItemSerializer.new(items)
    end
  end

  def show
    unless search_attribute && !search_value.blank?
      check_params(['search'])
    else
      item = Item.search(search_attribute, search_value).first
      render json: ItemSerializer.new(item)
    end
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
