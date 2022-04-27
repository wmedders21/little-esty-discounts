require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:bulk_discounts).through(:item) }
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

    it '#ready_to_ship' do
      merchant = Merchant.create(name: "Braum's")
      item = merchant.items.create(name: "Beyblade", description: "Let it rip!", unit_price: 1000)

      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      nate = Customer.create!(first_name: "Nate", last_name: "Chaffee")
      barty = Customer.create!(first_name: "Barty", last_name: "Dasher")
      zeke = Customer.create!(first_name: "Zeke", last_name: "Bristol")
      flipper = Customer.create!(first_name: "Flipper", last_name: "McDaniel")
      tildy = Customer.create!(first_name: "Tildy", last_name: "Lynch")

      invoice_1 = bob.invoices.create!(status: 1)
      invoice_2 = barty.invoices.create!(status: 1)
      invoice_3 = nate.invoices.create!(status: 1)
      invoice_4 = zeke.invoices.create!(status: 1)
      invoice_5 = flipper.invoices.create!(status: 1)
      invoice_6 = tildy.invoices.create!(status: 1)

      invoice_item_1 = item.invoice_items.create(invoice_id:invoice_1.id, quantity:3, unit_price: 1000, status: 1)
      invoice_item_2 = item.invoice_items.create(invoice_id:invoice_2.id, quantity:3, unit_price: 3000)
      invoice_item_3 = item.invoice_items.create(invoice_id:invoice_3.id, quantity:3, unit_price: 3000)
      invoice_item_4 = item.invoice_items.create(invoice_id:invoice_4.id, quantity:3, unit_price: 3000)
      invoice_item_5 = item.invoice_items.create(invoice_id:invoice_5.id, quantity:3, unit_price: 3000)
      invoice_item_6 = item.invoice_items.create(invoice_id:invoice_6.id, quantity:3, unit_price: 3000)

      expect(InvoiceItem.ready_to_ship).to eq([invoice_item_1])
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

    it '#invoice_dates' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 4, status: 1, unit_price: 295)

      expect(ii_1.invoice_dates).to eq('Tuesday, April 05, 2022')
    end

    it '#belongs_to_merchant' do
      walmart = Merchant.create!(name: "Wal-Mart")
      kmart = Merchant.create!(name: "K-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 4, status: 1, unit_price: 295)

      expect(ii_1.belongs_to_merchant("#{walmart.id}")).to eq(true)
      expect(ii_1.belongs_to_merchant("#{kmart.id}")).to eq(false)
    end
  end
end
