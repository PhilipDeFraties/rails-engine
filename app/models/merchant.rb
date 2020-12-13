class Merchant < ApplicationRecord
  has_many :items, :dependent => :delete_all
  has_many :invoices, :dependent => :delete_all
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
end
