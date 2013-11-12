class Vendor
  attr_reader :id, :name, :no_employees, :market_id

  def initialize(array)
    @id = array[0]
    @name = array[1]
    @no_employees = array[2]
    @market_id = array[3]
  end

  def self.all
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

def self.find(id)
    all.find do |vendor|
      vendor.id.to_i == id
    end
  end

  def self.no_employees(no_employees)
    all.find do |vendor|
      vendor.no_employees == no_employees
    end
  end

  def self.find_by_name(name)
    all.select do |vendor|
      vendor.name =~ /#{name}/i 
    end
  end

  def market
    Market.all.select do |market|
      market.market_id == market_id
    end
  end

  def products
    Products.
  end

  def sale #returns Sale instances associated with market by vendor_id
  end

  def revenue #returns sum of all vendor's sales
  end

end


