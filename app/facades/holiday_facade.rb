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
    # binding.pry
    create_holidays.sort_by().take(3)
  end

  def service
    NagerService.new
  end
end
