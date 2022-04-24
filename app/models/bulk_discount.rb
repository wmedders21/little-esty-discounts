class BulkDiscount < ApplicationRecord
  belongs_to :item
  validates_presence_of :discount_percentage
  validates_presence_of :quantity_threshold
end
