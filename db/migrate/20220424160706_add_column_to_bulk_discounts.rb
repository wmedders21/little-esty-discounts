class AddColumnToBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    add_reference :bulk_discounts, :item, foreign_key: true
    remove_column :bulk_discounts, :merchant_id
  end
end
