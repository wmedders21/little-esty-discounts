class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: [:disabled, :enabled]

  def unit_price_to_currency
    "%.2f" % (unit_price.to_f/100).truncate(2)
  end

  def self.items_by_merchant(merchant_id)
    joins(:invoice_items).where(merchant_id: merchant_id)
  end
end
