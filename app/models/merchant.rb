class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions
  has_many :invoice_items

end
