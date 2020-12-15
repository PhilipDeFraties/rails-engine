class ItemSerializer < BaseSerializer
  attributes :name,
             :description,
             :unit_price,
             :merchant_id,
             :created_at,
             :updated_at
  belongs_to :merchant
end
