class Repo
  attr_reader :name, :contributers

  def initialize(data)
    @name = data[:name]
    @contributers = data[:contributers]
  end
end
