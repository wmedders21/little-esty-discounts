class NagerService
  def get_list
    response = HTTParty.get("https://date.nager.at/api/v1/Get/US/#{get_year}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_year
    Time.now.year
  end
end
