require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer)}
    it { should have_many(:transactions)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
  end

  describe 'class methods' do
    it '#incomplete' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      item_2 = walmart.items.create!(name: "eraser", description: "rubber bit", unit_price: 200)
      item_3 = walmart.items.create!(name: "candle", description: "beeswax", unit_price: 1000)
      item_4 = walmart.items.create!(name: "calculator", description: "scientific", unit_price: 2000)
      item_5 = walmart.items.create!(name: "ball", description: "soccer", unit_price: 900)
      item_6 = walmart.items.create!(name: "notebook", description: "leatherbound", unit_price: 2500)
      item_7 = walmart.items.create!(name: "wine glass", description: "stemless", unit_price: 350)
      item_8 = walmart.items.create!(name: "banjo", description: "five string", unit_price: 30100)
      item_9 = walmart.items.create!(name: "golf tees", description: "2 1/2 inch", unit_price: 100)
      item_10 = walmart.items.create!(name: "radio", description: "AM/FM", unit_price: 900)
      item_11 = walmart.items.create!(name: "adult diaper", description: "family size", unit_price: 400)
      invoice_1 = bob.invoices.create!(status: 1)
      invoice_2 = bob.invoices.create!(status: 1)
      invoice_3 = bob.invoices.create!(status: 1)
      invoice_4 = bob.invoices.create!(status: 1)
      invoice_5 = bob.invoices.create!(status: 1)
      invoice_6 = bob.invoices.create!(status: 1)
      invoice_7 = bob.invoices.create!(status: 1)
      invoice_8 = bob.invoices.create!(status: 1)
      invoice_9 = bob.invoices.create!(status: 1)
      invoice_10 = bob.invoices.create!(status: 1)
      invoice_11 = bob.invoices.create!(status: 1)
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, status: 1)
      InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, status: 0)
      InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, status: 1)
      InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, status: 0)
      InvoiceItem.create!(invoice_id: invoice_9.id, item_id: item_9.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_10.id, item_id: item_10.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_11.id, item_id: item_11.id, quantity: 1, status: 2)

      expect(Invoice.incomplete).to eq([invoice_1, invoice_4, invoice_7, invoice_8])
    end

    it '#sorted_by_newest' do
      walmart = Merchant.create!(name: "Wal-Mart")
      bob = Customer.create!(first_name: "Bob", last_name: "Benson")
      item_1 = walmart.items.create!(name: "pickle", description: "sour cucumber", unit_price: 300)
      item_2 = walmart.items.create!(name: "eraser", description: "rubber bit", unit_price: 200)
      item_3 = walmart.items.create!(name: "candle", description: "beeswax", unit_price: 1000)
      item_4 = walmart.items.create!(name: "calculator", description: "scientific", unit_price: 2000)
      item_5 = walmart.items.create!(name: "ball", description: "soccer", unit_price: 900)
      item_6 = walmart.items.create!(name: "notebook", description: "leatherbound", unit_price: 2500)
      item_7 = walmart.items.create!(name: "wine glass", description: "stemless", unit_price: 350)
      item_8 = walmart.items.create!(name: "banjo", description: "five string", unit_price: 30100)
      item_9 = walmart.items.create!(name: "golf tees", description: "2 1/2 inch", unit_price: 100)
      item_10 = walmart.items.create!(name: "radio", description: "AM/FM", unit_price: 900)
      item_11 = walmart.items.create!(name: "adult diaper", description: "family size", unit_price: 400)
      invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
      invoice_2 = bob.invoices.create!(status: 1, created_at: '04 Apr 2022 00:53:36 UTC +00:00')
      invoice_3 = bob.invoices.create!(status: 1, created_at: '03 Apr 2022 00:53:36 UTC +00:00')
      invoice_4 = bob.invoices.create!(status: 1, created_at: '02 Apr 2022 00:53:36 UTC +00:00')
      invoice_5 = bob.invoices.create!(status: 1, created_at: '01 Apr 2022 00:53:36 UTC +00:00')
      invoice_6 = bob.invoices.create!(status: 1, created_at: '06 Apr 2022 00:53:36 UTC +00:00')
      invoice_7 = bob.invoices.create!(status: 1, created_at: '07 Apr 2022 00:53:36 UTC +00:00')
      invoice_8 = bob.invoices.create!(status: 1, created_at: '08 Apr 2022 00:53:36 UTC +00:00')
      invoice_9 = bob.invoices.create!(status: 1, created_at: '09 Apr 2022 00:53:36 UTC +00:00')
      invoice_10 = bob.invoices.create!(status: 1, created_at: '10 Apr 2022 00:53:36 UTC +00:00')
      invoice_11 = bob.invoices.create!(status: 1, created_at: '11 Apr 2022 00:53:36 UTC +00:00')
      InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, status: 1)
      InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, status: 0)
      InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, status: 1)
      InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, status: 0)
      InvoiceItem.create!(invoice_id: invoice_9.id, item_id: item_9.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_10.id, item_id: item_10.id, quantity: 1, status: 2)
      InvoiceItem.create!(invoice_id: invoice_11.id, item_id: item_11.id, quantity: 1, status: 2)

      expect(Invoice.sorted_by_newest.take(5)).to eq([invoice_11, invoice_10, invoice_9, invoice_8, invoice_7])
    end

    describe 'instance methods' do

      it '#dates' do
        bob = Customer.create!(first_name: "Bob", last_name: "Benson")
        invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
        expect(invoice_1.dates).to eq('Tuesday, April 05, 2022')
      end

      it '#full_name' do
        bob = Customer.create!(first_name: "Bob", last_name: "Benson")
        invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
        expect(invoice_1.full_name).to eq('Bob Benson')
      end

      it '#invoice_total_revenue' do
        merchant = Merchant.create(name: "Braum's")
        item1 = merchant.items.create(name: "Toaster", description: "Four slots", unit_price: 1000)
        item2 = merchant.items.create(name: "Poleaxe", description: "8 foot reach!", unit_price: 1000)

        bob = Customer.create!(first_name: "Bob", last_name: "Benson")

        invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

        invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
        invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)

        expect(invoice_1.invoice_total_revenue).to eq(267000)
      end

      it '#merchant_invoice_revenue' do
        merchant = Merchant.create(name: "Braum's")
        merchant_2 = Merchant.create(name: "Selly MacSellerson")
        item1 = merchant.items.create(name: "Toaster", description: "Four slots", unit_price: 1000)
        item2 = merchant.items.create(name: "Poleaxe", description: "8 foot reach!", unit_price: 1000)
        item3 = merchant_2.items.create(name: "Canned Frog Legs", description: "Half pound", unit_price: 10000)

        bob = Customer.create!(first_name: "Bob", last_name: "Benson")

        invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

        invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
        invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)
        invoice_item_3 = item3.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)

        expect(invoice_1.merchant_invoice_revenue(merchant.id)).to eq(267000)
      end

      it '#merchant_discounted_revenue' do
        merchant = Merchant.create(name: "Braum's")
        merchant_2 = Merchant.create(name: "Selly MacSellerson")

        item1 = merchant.items.create(name: "Toaster", description: "Four slots", unit_price: 1000)
        item2 = merchant.items.create(name: "Poleaxe", description: "8 foot reach!", unit_price: 1000)
        item3 = merchant_2.items.create(name: "Canned Frog Legs", description: "Half pound", unit_price: 10000)

        bob = Customer.create!(first_name: "Bob", last_name: "Benson")

        invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

        invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
        invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)
        invoice_item_3 = item3.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)

        merchant.bulk_discounts.create!(name: 'Mega Liquidation', discount_percentage: 50, quantity_threshold: 100)
        merchant.bulk_discounts.create!(name: 'Yeehaw Sale', discount_percentage: 30, quantity_threshold: 40)

        expect(invoice_1.merchant_discounted_revenue(merchant.id)).to eq(142500)
      end

      it '#discounted_revenue' do
        merchant = Merchant.create(name: "Braum's")
        item1 = merchant.items.create(name: "Toaster", description: "Four slots", unit_price: 1000)
        item2 = merchant.items.create(name: "Poleaxe", description: "8 foot reach!", unit_price: 1000)

        bob = Customer.create!(first_name: "Bob", last_name: "Benson")

        invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

        invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
        invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)

        merchant.bulk_discounts.create!(name: 'Mega Liquidation', discount_percentage: 50, quantity_threshold: 100)
        merchant.bulk_discounts.create!(name: 'Yeehaw Sale', discount_percentage: 30, quantity_threshold: 40)

        expect(invoice_1.discounted_revenue).to eq(142500)
      end
    end
  end
end
