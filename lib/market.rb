require 'CSV'

class Market
  attr_reader :market_id, :name, :address, :city, :county, :state, :zip #etc

  def initialize(array)
    @market_id = array[0]
    @name = array[1]
    @address = array[2]
    @city = array[3]
    @county = array[4]
    @state = array[5]
    @zip = array[6]
  end

  def self.all
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

  def self.find(id)
    all.find do |market|
      market.market_id.to_i == id
    end
  end
end

puts Market.find(2).inspect