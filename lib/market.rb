class Market
  attr_reader :market_id, :name, :address, :city, :county, :state, :zip

  def initialize(market_array)
    @market_id = market_array[0]
    @name = market_array[1]
    @address = market_array[2]
    @city = market_array[3]
    @county = market_array[4]
    @state = market_array[5]
    @zip = market_array[6]
  end

  def self.all
    CSV.read("./support/markets.csv").map do |market_array|
      Market.new(market_array)
    end
  end

  def self.find(id)
    all.find do |market|
      market.market_id.to_i == id
    end
  end

  def self.find_by_address(address)
    all.find do |market|
      market.address == address
    end
  end

  def self.find_by_city(city_name)
    all.select do |market|
      market.city == city_name
    end
  end

  def vendors
    Vendor.all.select do |vendor|
      vendor.market_id == market_id
    end
  end

end

Market.find(2).vendors
# puts Market.find(2).inspect