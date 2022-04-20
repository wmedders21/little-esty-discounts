require 'rails_helper'

RSpec.describe Repo do
  it 'exists and has a name attribute and contributers attribute' do
    repo_data = {name: 'little-esty-shop',
                 contributers: [{name: "wmedders21", commits: 78},
                                {name: "James-Harkins", commits: 55},
                                {name: "enalihai", commits: 51},
                                {name: "DrewProebstel", commits: 49}],
                  merges: 90}
    repo = Repo.new(repo_data)
    expect(repo.class).to eq(Repo)
    expect(repo.name).to eq('little-esty-shop')
    expect(repo.contributers).to be_a(Array)
    expect(repo.contributers[0]).to be_a(Hash)
    expect(repo.merges).to eq(90)
  end
end
