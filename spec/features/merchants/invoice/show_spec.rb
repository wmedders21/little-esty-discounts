require 'rails_helper'

RSpec.describe 'the merchant invoice show page' do
  it 'shows all the attributes for an invoice', :vcr do
    merchant = Merchant.create(name: "Braum's")
    item1 = merchant.items.create(name: "Toast", description: "Let it rip!", unit_price: 1000)
    bob = Customer.create!(first_name: "Bob", last_name: "Benson")
    invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
    visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"
    expect(page).to have_content("#{invoice_1.id}")
    expect(page).to have_content("completed")
    expect(page).to have_content("Bob Benson")
    expect(page).to have_content('Tuesday, April 05, 2022')
  end


  it 'shows the quatity and price of item sold', :vcr do
    merchant = Merchant.create(name: "Braum's")
    item1 = merchant.items.create(name: "Toast", description: "Let it rip!", unit_price: 1000)
    bob = Customer.create!(first_name: "Bob", last_name: "Benson")
    invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
    invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
    visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"
    expect(page).to have_content("45")
    expect(page).to have_content("10.00")
  end

  it 'the quatity and price of item sold', :vcr do
    merchant = Merchant.create(name: "Braum's")
    merchant2 = Merchant.create(name: "Target")

    item1 = merchant.items.create(name: "Toast", description: "Let it rip!", unit_price: 1000)
    item2 = merchant2.items.create(name: "Polearm", description: "Let it rip!", unit_price: 1000)

    bob = Customer.create!(first_name: "Bob", last_name: "Benson")
    dave = Customer.create!(first_name: "Dave", last_name: "Fogherty")
    invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
    invoice_2 = dave.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

    invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
    invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)
    visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"

    expect(page).to_not have_content("222")
    expect(page).to_not have_content("3499")
    expect(page).to_not have_content("Polearm")
  end

 it 'shows total revenue', :vcr do
    merchant = Merchant.create(name: "Braum's")
    merchant2 = Merchant.create(name: "Target")

    item1 = merchant.items.create(name: "Toast", description: "Let it rip!", unit_price: 1000)
    item2 = merchant.items.create(name: "Polearm", description: "Let it rip!", unit_price: 1000)

    bob = Customer.create!(first_name: "Bob", last_name: "Benson")

    invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
    invoice_2 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

    invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
    invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)
    visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content("2670.00")
  end

  it 'displays the total revenue after bulk discounts are applied' do
    merchant = Merchant.create(name: "Braum's")
    item1 = merchant.items.create(name: "Toaster", description: "Four slots", unit_price: 1000)
    item2 = merchant.items.create(name: "Poleaxe", description: "8 foot reach!", unit_price: 1000)

    bob = Customer.create!(first_name: "Bob", last_name: "Benson")

    invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')
    invoice_2 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

    invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
    invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)

    merchant.bulk_discounts.create!(name: 'Mega Liquidation', discount_percentage: 50, quantity_threshold: 100)
    merchant.bulk_discounts.create!(name: 'Yeehaw Sale', discount_percentage: 30, quantity_threshold: 40)

    visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"

    expect(page).to have_content("2670.00")
    expect(page).to have_content("1425.00")
  end

  it 'displays a link to the applied bulk discount next to each invoice item (if any)' do
    merchant = Merchant.create(name: "Braum's")
    item1 = merchant.items.create(name: "Toaster", description: "Four slots", unit_price: 1000)
    item2 = merchant.items.create(name: "Poleaxe", description: "8 foot reach!", unit_price: 1000)

    bob = Customer.create!(first_name: "Bob", last_name: "Benson")

    invoice_1 = bob.invoices.create!(status: 1, created_at: '05 Apr 2022 00:53:36 UTC +00:00')

    invoice_item_1 = item1.invoice_items.create(invoice_id:invoice_1.id, quantity:45, unit_price: 1000)
    invoice_item_2 = item2.invoice_items.create(invoice_id:invoice_1.id, quantity:222, unit_price: 1000)

    bd_1 = merchant.bulk_discounts.create!(name: 'Mega Liquidation', discount_percentage: 50, quantity_threshold: 100)
    bd_2 = merchant.bulk_discounts.create!(name: 'Yeehaw Sale', discount_percentage: 30, quantity_threshold: 40)

    visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"
  
    within "#item-#{invoice_item_1.id}" do
      expect(page).to have_no_link("Mega Liquidation")
      click_link "Yeehaw Sale"
      expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/#{bd_2.id}")
    end
    visit "/merchants/#{merchant.id}/invoices/#{invoice_1.id}"

    within "#item-#{invoice_item_2.id}" do
      expect(page).to have_no_link("Yeehaw Sale")
      click_link "Mega Liquidation"
      expect(current_path).to eq("/merchants/#{merchant.id}/bulk_discounts/#{bd_1.id}")
    end
  end

  describe 'as a merchant' do
    describe 'when i visit my merchant invoice show page' do
      before :each do
        @merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        @item_1 = @merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        @item_2 = @merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        @item_3 = @merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)
        @customer = Customer.create!(first_name: "Steven", last_name: "Seagal")
        @invoice_1 = @customer.invoices.create!(status: 1)
        @invoice_2 = @customer.invoices.create!(status: 0)
        @invoice_item_1 = @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity:45, unit_price: 1000, status: 0)
        @invoice_item_2 = @item_2.invoice_items.create!(invoice_id: @invoice_1.id, quantity:222, unit_price: 1000, status: 2)
        @invoice_item_3 = @item_2.invoice_items.create!(invoice_id: @invoice_2.id, quantity:222, unit_price: 1000, status: 1)
        @invoice_item_4 = @item_3.invoice_items.create!(invoice_id: @invoice_1.id, quantity:222, unit_price: 1000, status: 1)

        visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
      end

      it "i see that each invoice item status is a select field
        and i see that the invoice item's current status is selected", :vcr do

        within "#item-#{@invoice_item_1.id}" do
          expect(page).to have_select(:status, selected: 'Pending')
        end

        within "#item-#{@invoice_item_2.id}" do
          expect(page).to have_select(:status, selected: 'Shipped')
        end

        within "#item-#{@invoice_item_4.id}" do
          expect(page).to have_select(:status, selected: 'Packaged')
        end
      end

      it "can update the item status", :vcr do

        within "#item-#{@invoice_item_4.id}" do
          select 'Shipped', :from => :status
          click_button("Update Item Status")
        end

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")

        within "#item-#{@invoice_item_4.id}" do
          expect(page).to have_select(:status, selected: 'Shipped')
        end

        within "#item-#{@invoice_item_1.id}" do
          expect(page).to have_select(:status, selected: 'Pending')
        end

        within "#item-#{@invoice_item_2.id}" do
          expect(page).to have_select(:status, selected: 'Shipped')
        end
      end
    end
  end
end
