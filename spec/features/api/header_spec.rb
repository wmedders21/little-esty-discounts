require 'rails_helper'

RSpec.describe 'the Api' do
  it 'displays the name of github repo somewhere' do
    visit 'admin/merchants'
    expect(page).to have_content("little-esty-shop")
  end
  it 'displays the contributions and contributers' do
    visit 'admin/merchants'
    expect(page).to have_content("BrianZanti: 51 commits")
  end
end
