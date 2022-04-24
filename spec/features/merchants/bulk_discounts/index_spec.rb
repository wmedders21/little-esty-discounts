require 'rails_helper'

RSpec.describe 'Bulk Discounts index' do
  it 'displays a merchants discounts with their discount percentage and quantity thresholds' do
    merchant_1 = Merchant.create(name: "Braum's")
    merchant_2 = Merchant.create(name: "Gemstones of Power")
    big_deal = merchant_1.bulk_discounts.create!(name: 'Big Deal', discount_percentage: 25, quantity_threshold: 5)
    super_deal = merchant_1.bulk_discounts.create!(name: 'Super Deal', discount_percentage: 50, quantity_threshold: 10)
    mega_deal = merchant_1.bulk_discounts.create!(name: 'Mega Deal', discount_percentage: 75, quantity_threshold: 15)
    other_deal = merchant_2.bulk_discounts.create!(name: 'Other Deal', discount_percentage: 10, quantity_threshold: 100)


    visit "/merchants/#{merchant_1.id}/bulk_discounts"
    
    expect(page).to have_content('Big Deal')
    expect(page).to have_content('25%')
    expect(page).to have_content('5')

    expect(page).to have_content('Super Deal')
    expect(page).to have_content('50%')
    expect(page).to have_content('10')

    expect(page).to have_content('Mega Deal')
    expect(page).to have_content('75%')
    expect(page).to have_content('15')

    expect(page).to have_no_content('Other Deal')
    expect(page).to have_no_content('10%')
    expect(page).to have_no_content('100')
  end
end