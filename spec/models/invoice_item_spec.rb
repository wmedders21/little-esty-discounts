require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'class methods' do
    it '#total_revenue' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      item_2 = walmart.items.create!(name: "eraser", description: "rubber bit", unit_price: 200)

      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 6, status: 1, unit_price: 295)
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 2, status: 0, unit_price: 215)

      expect(InvoiceItem.total_revenue).to eq(2200)
    end
  end

  describe 'instance methods' do
    it '#discount' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
      bd_1 = walmart.bulk_discounts.create!(name: 'Deal', quantity_threshold: 3, discount_percentage: 20)
      bd_2 = walmart.bulk_discounts.create!(name: 'Big Deal', quantity_threshold: 5, discount_percentage: 75)
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 4, status: 1, unit_price: 295)
      ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 6, status: 1, unit_price: 295)

      expect(ii_1.discount).to eq([bd_1])
      expect(ii_2.discount).to eq([bd_2])
    end
  end
end
