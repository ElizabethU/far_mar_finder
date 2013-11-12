class Sale
  attr_reader :name, :address #etc

  def initialize(array)
    @name = array[1]
    @address = array[2]
  end

  def self.all
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

end
