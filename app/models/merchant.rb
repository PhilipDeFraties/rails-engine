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

  def self.rank_by_items_sold(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result = 'success' AND invoices.status = 'shipped'")
      .group(:id)
      .order("items_sold DESC")
      .limit(quantity)
  end

  def self.revenue(id)
    joins(invoices: [:invoice_items, :transactions])
      .where("merchants.id = #{id} AND transactions.result = 'success' AND invoices.status = 'shipped'")
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
