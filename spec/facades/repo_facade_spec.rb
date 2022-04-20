require 'rails_helper'

RSpec.describe 'Repo Facade' do
  it 'creates a repo object' do
    repo = RepoFacade.create_repo
    expect(repo).to be_a(Repo)
  end
end
