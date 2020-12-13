class MerchantSerializer < BaseSerializer
  attributes :name
  has_many :items
  has_many :invoices
end
