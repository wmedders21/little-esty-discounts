class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :invoices, through: :merchant
  validates_presence_of :discount_percentage
  validates_presence_of :quantity_threshold
  validates_presence_of :name
end
