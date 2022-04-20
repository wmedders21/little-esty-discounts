require 'rails_helper'

RSpec.describe 'Github Service' do
  it '#get_url' do
    github_service = GithubService.new
    url = 'https://api.github.com/repos/enalihai/little-esty-shop'
    json = github_service.get_url(url)
    expect(json[:name]).to eq("little-esty-shop")
  end
end
