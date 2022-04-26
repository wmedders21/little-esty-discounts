require 'rails_helper'

RSpec.describe HolidayFacade do
  it '#next_three' do
    Timecop.travel('2022-12-12')
    holidays = HolidayFacade.new
    expect(holidays.next_three.count).to eq(3)
    expect(holidays.next_three[0].name).to eq("Christmas Day")
    expect(holidays.next_three[1].name).to eq("New Year's Day")
    expect(holidays.next_three[2].name).to eq("Martin Luther King, Jr. Day")
    Timecop.return
  end
end
