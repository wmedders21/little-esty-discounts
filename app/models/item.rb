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

  def top_selling_date
    invoices.select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
            .group('invoices.id')
            .order('revenue desc')
            .first
            .created_at

    # SELECT invoices.created_at FROM record
    #   INNER JOIN invoice_items ON record.id = invoice_items.item_id
    #   INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
    #  ORDER BY invoice_items.quantity * invoice_items.unit_price DESC LIMIT 1) AS date'
  end
end
