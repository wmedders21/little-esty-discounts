class Holiday
  attr_reader :name
  def initialize(data_hash)
    @name = data_hash[:name]
    @date = data_hash[:date]
  end
end
