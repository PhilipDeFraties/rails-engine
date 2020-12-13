class MerchantSerializer < BaseSerializer
  attributes :name
  has_many :items
end
