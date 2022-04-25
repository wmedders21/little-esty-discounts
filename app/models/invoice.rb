class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: ["in progress".to_sym, :completed, :cancelled]

  def self.incomplete
    joins(:invoice_items)
    .where('invoice_items.status != ?', '2')
    .distinct
    .order(:id)
  end

  def self.sorted_by_newest
    order(created_at: :desc)
  end

  def dates
    created_at.strftime("%A, %B %d, %Y")
  end

  def full_name
    customer.first_name + " " +  customer.last_name
  end

  def invoice_total_revenue
    invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def discounted_revenue
    discount = invoice_items.joins(:bulk_discounts)
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity *(bulk_discounts.discount_percentage)/100.00) as total_discount')
      .group('invoice_items.id')
      .sum(&:total_discount)
    invoice_total_revenue - discount
  end
end
