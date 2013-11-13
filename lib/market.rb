class Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip

  def initialize(market_array)
    @id = market_array[0].to_i
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

  def self.find(market_id)
    all.find do |market|
      market.id == market_id
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

  def self.find_by_name(name)
    all.select do |market_instance|
      market_instance.name =~ /#{name}/i 
    end
  end

  def vendors
    Vendor.all.select do |vendor|
      vendor.market_id == id
    end
  end

  def self.random #optimize later in far_mar
    all.sample
  end

  def products
    prod_array = Vendor.by_market(id).map do |vendor| 
      vendor.products
    end
    prod_array.flatten
  end

  def self.search(search_term) #returns collection Market
    find_by_name(search_term) + Vendor.find_by_name(search_term) 
  end

  def preferred_vendor
    Vendor.all.find 
end

# Market.find(2).vendors
# puts Market.find(2).inspect