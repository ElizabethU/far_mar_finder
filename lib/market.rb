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
    @all_market ||= CSV.read("./support/markets.csv").map do |market_array|
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

  def vendor_revenue_data
    @vendor_revenue_list ||= @vendor_hash = {}
    vendors.select do |vendor_instance| 
      @vendor_hash[vendor_instance.revenue] = vendor_instance
    end
    @vendor_hash
  end

  # def preferred_vendor #we think we can do this more cleanly
  #   highest_rev = 0
  # #   vendor_hash = {}
  #   vendors.select do |vendor_instance| 
  #     vendor_hash[vendor_instance.revenue] = vendor_instance
  #   end
  #   vendor_hash.each do |revenue, vendor_instance| 
  #     if revenue >= highest_rev
  #       highest_rev = revenue
  #     end
  #   end
  #   vendor_hash[highest_rev] 
  # end
    

  def preferred_vendor #we think we can do this more cleanly
    # vendor_revenue_data
    r = vendor_revenue_data.keys.sort.last
    @vendor_hash[r]
    # highest_rev = 0
    # highest_rev_obj = nil
    # vendors.select do |vendor_instance| 
    #   rev = vendor_instance.revenue 
    #   if rev >= highest_rev
    #     highest_rev = rev
    #     highest_rev_obj = vendor_instance
    #   end
    # end
    # highest_rev_obj
  end

  def prefered_vendor(date) #This is for you, Bookis!
    
  end

  def worst_vendor
    r = vendor_revenue_data.keys.sort.first
    @vendor_hash[r]
    # lowest_rev = 50000
    # lowest_rev_obj = nil
    # vendors.select do |vendor_instance|
    #   rev = vendor_instance.revenue
    #   if rev <= lowest_rev
    #     lowest_rev = rev
    #     lowest_rev_obj = vendor_instance
    #   end
    # end
    #   lowest_rev_obj
  end
end
# Market.find(2).vendors
# puts Market.find(2).inspect