class NagerService
  def get_list
    response = HTTParty.get('https://date.nager.at/api/v1/Get/US/2022')
    JSON.parse(response.body, symbolize_names: true)
  end
end
