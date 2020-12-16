class Merchant < ApplicationRecord
  has_many :items, :dependent => :delete_all
  has_many :invoices, :dependent => :delete_all
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices


  def self.rank_by_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result = 'success' AND invoices.status = 'shipped'")
      .group(:id)
      .order("revenue DESC")
      .limit(quantity)
  end

end
