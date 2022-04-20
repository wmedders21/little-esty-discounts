require 'rails_helper'

RSpec.describe 'the Api' do
  it 'displays the name of github repo somewhere', :vcr do
    merchant_1 = Merchant.create!(name: "Mollys", status: 1)
    merchant_2 = Merchant.create!(name: "Berrys", status: 1)
    merchant_3 = Merchant.create!(name: "Jimmys", status: 0)

    visit 'admin/merchants'
    expect(page).to have_content("little-esty-shop")
  end
  it 'displays the contributions and contributers', :vcr do
    merchant_1 = Merchant.create!(name: "Mollys", status: 1)
    merchant_2 = Merchant.create!(name: "Berrys", status: 1)
    merchant_3 = Merchant.create!(name: "Jimmys", status: 0)

    visit 'admin/merchants'
    expect(page).to have_content("BrianZanti: 51 commits")
  end
  it 'displays the number of merged pull requests', :vcr do
    merchant_1 = Merchant.create!(name: "Mollys", status: 1)
    merchant_2 = Merchant.create!(name: "Berrys", status: 1)
    merchant_3 = Merchant.create!(name: "Jimmys", status: 0)

    visit 'admin/merchants'
    expect(page).to have_content("Total Merged Pull Requests: ")
  end
end
