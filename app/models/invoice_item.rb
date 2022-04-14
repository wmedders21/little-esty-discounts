class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def invoice_dates
    invoice.created_at.strftime("%A, %B %d, %Y")
  end

  def self.ready_to_ship
    where(status: "packaged").order('created_at DESC')
  end
end
