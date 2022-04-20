require './app/services/github_service.rb'

class RepoFacade
  def self.create_repo
    json = GithubService.get_url('https://api.github.com/repos/enalihai/little-esty-shop')
    Repo.new(json)
  end
end
