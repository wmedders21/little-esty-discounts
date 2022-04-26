class HolidayFacade
  def create_holidays
    data = service.get_list
    holidays = []
    data.each do |hash|
      holidays << Holiday.new(hash)
    end
    holidays
  end

  def next_three
    future = create_holidays.find_all { |holiday| holiday.date > Time.now }
    if future.count < 3
      future << create_holidays[0..2]
    end
     future.flatten.take(3)
  end

  def service
    NagerService.new
  end
end
