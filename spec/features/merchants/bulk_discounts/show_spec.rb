require 'rails_helper'

RSpec.describe 'bulk discounts show' do
  it 'diplays the quantity threshold and discount percentage' do
    merchant_1 = Merchant.create(name: "Braum's")
    merchant_2 = Merchant.create(name: "Gemstones of Power")
    big_deal = merchant_1.bulk_discounts.create!(name: 'Big Deal', discount_percentage: 25, quantity_threshold: 5)
    other_deal = merchant_2.bulk_discounts.create!(name: 'Other Deal', discount_percentage: 10, quantity_threshold: 100)

    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{big_deal.id}"

    expect(page).to have_content("25")
    expect(page).to have_content("5")
    expect(page).to have_no_content("10")
    expect(page).to have_no_content("100")
  end

  it 'can edit the discount' do
    merchant_1 = Merchant.create(name: "Braum's")
    big_deal = merchant_1.bulk_discounts.create!(name: 'Big Deal', discount_percentage: 25, quantity_threshold: 5)
    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{big_deal.id}"

    expect(page).to have_content("25")
    expect(page).to have_content("5")

    click_link "Edit Discount"
    fill_in :name, with: "Bigger Deal"
    fill_in :discount_percentage, with: "30"
    fill_in :quantity_threshold, with: "3"
    # save_and_open_page
    click_button "Submit"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{big_deal.id}")
    expect(page).to have_content("30")
    expect(page).to have_content("3")
    expect(page).to have_no_content("25")
    expect(page).to have_no_content("5")
  end
end
