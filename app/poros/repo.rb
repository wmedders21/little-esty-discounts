class Repo
  attr_reader :name, :contributers, :merges

  def initialize(data)
    @name = data[:name]
    @contributers = data[:contributers]
    @merges = data[:merges]
  end
end
