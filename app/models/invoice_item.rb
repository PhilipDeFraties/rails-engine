class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity
  validates_numericality_of :quantity, greater_than: 0

  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice

  def self.revenue_across_dates(start_date, end_date)
    joins(:transactions)
      .where("transactions.result = 'success' AND invoices.status = 'shipped' AND invoices.created_at >= '#{start_date.to_datetime.beginning_of_day}' AND invoices.created_at <= '#{end_date.to_datetime.end_of_day}'")
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
