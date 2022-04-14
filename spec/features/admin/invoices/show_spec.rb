require 'rails_helper'

RSpec.describe "Admin Invoices Show" do
  it 'displays invoice info relating to invoice' do
    bob = Customer.create!(first_name: "Bob", last_name: "Benson")
    invoice_1 = bob.invoices.create!(status: 1, created_at: '01 Jul 2022 01:00:00')
    invoice_2 = bob.invoices.create!(status: 1, created_at: '02 Apr 2022 01:00:00')

    visit "/admin/invoices/#{invoice_1.id}"
    # save_and_open_page
    expect(page).to have_content("#{invoice_1.id}")
    expect(page).to have_content("completed")
    expect(page).to have_content("Bob Benson")
    expect(page).to have_content('Friday, July 01, 2022')
    expect(page).to have_no_content('Saturday, April 02, 2022')
  end
end
