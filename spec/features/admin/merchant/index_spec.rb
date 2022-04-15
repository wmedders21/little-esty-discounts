require 'rails_helper'
require 'rake'
Rails.application.load_tasks

RSpec.describe "Admin Merchants Index" do
  it 'displays a header showing the Admin Merchants Index' do
    visit '/admin/merchants'

    within(".header") do
      expect(page).to have_content("Merchant Index - Admin")
    end
  end

  it 'displays all of the merchants' do
    merchant_1 = Merchant.create!(name: "Mollys")
    merchant_2 = Merchant.create!(name: "Berrys")
    merchant_3 = Merchant.create!(name: "Jimmys")

    visit '/admin/merchants'

    within(".index") do
      expect(page).to have_content('Mollys')
      expect(page).to have_content('Berrys')
      expect(page).to have_content('Jimmys')
      expect(page).to_not have_content('Willys')
    end
  end

  it 'contains a button to enable or disable' do
    merchant_1 = Merchant.create!(name: "Mollys")

    visit '/admin/merchants'

    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
    expect(page).to_not have_button("LoremIpsum")
  end

  it 'updates a merchant between enable/disable' do
    merchant_1 = Merchant.create!(name: "Mollys", status: 1)
    merchant_2 = Merchant.create!(name: "Jerrys", status: 1)
    merchant_3 = Merchant.create!(name: "Berrys", status: 0)

    visit '/admin/merchants'

    expect(merchant_1.status).to eq("enabled")
    expect(merchant_2.status).to eq("enabled")
    expect(merchant_3.status).to eq("disabled")
    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
  end

  it 'loads into test db' do
    Rake::Task['csv_fake:customers'].invoke
    Rake::Task['csv_fake:merchants'].invoke
    Rake::Task['csv_fake:invoices'].invoke
    Rake::Task['csv_fake:items'].invoke
    Rake::Task['csv_fake:transactions'].invoke
    Rake::Task['csv_fake:invoice_items'].invoke
    expect(Customer.all.length).to eq(40)
  end
end
