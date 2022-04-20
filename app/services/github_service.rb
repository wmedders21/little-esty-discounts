class GithubService < BaseService
  def self.get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.name
    get_url('https://api.github.com/repos/enalihai/little-esty-shop')[:name]
  end

  def self.contributers
    get_url('https://api.github.com/repos/enalihai/little-esty-shop/contributors')
  end

  def self.contributers_with_commits
    contributers.map {|contributer| {name: contributer[:login], commits: contributer[:contributions]}}
  end
end
