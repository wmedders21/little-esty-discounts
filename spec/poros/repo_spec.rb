require 'rails_helper'

RSpec.describe Repo do
  it 'exists and has a name attribute' do
    repo_data = {name: 'little-esty-shop'}
    repo = Repo.new(repo_data)
    expect(repo.class).to eq(Repo)
    expect(repo.name).to eq('little-esty-shop')
  end
end
