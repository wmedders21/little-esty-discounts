class ApplicationController < ActionController::Base
  before_action :repo_info
  def repo_info
    @repo = RepoFacade.create_repo
  end
end
