class Holiday
  attr_reader :name, :date
  def initialize(data_hash)
    @name = data_hash[:name]
    @date = data_hash[:date]
  end
end
