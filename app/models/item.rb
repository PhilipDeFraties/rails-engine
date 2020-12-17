class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price, greater_than: 0

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
end
