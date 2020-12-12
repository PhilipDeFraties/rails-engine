class ItemSerializer < BaseSerializer
  attributes :name, :description, :unit_price, :merchant_id
  belongs_to :merchant
end
