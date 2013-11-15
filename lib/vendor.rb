class Vendor
  attr_reader :id, :name, :no_of_employees, :market_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @no_of_employees = array[2].to_i
    @market_id = array[3].to_i
  end

  def self.all
    @all_vendor ||= CSV.read("./support/vendors.csv").map do |vendor_array|
      Vendor.new(vendor_array)
    end
  end

  def self.find(id)
    all.find do |vendor|
      vendor.id == id
    end
  end

  def self.no_of_employees(no_employees)
    all.find do |vendor|
      vendor.no_of_employees == no_employees
    end
  end

  def self.find_by_name(name)
    all.select do |vendor|
      vendor.name =~ /#{name}/i 
    end
  end

  def self.by_market(id_of_market)
    all.select do |vendor|
      vendor.market_id ==  id_of_market
    end
  end

  def revenue
    sum = 0
    sales.each do |sale|
      sum += sale.amount
    end
    return sum
  end

  def self.revenue_date(date)
    total_sales = 0
    Sale.by_date(date).each do |sale|
      total_sales += sale.amount
    end
    total_sales
  end

  def market
    Market.find(market_id)
  end

  def products
    Product.by_vendor(id)
  end

  def sales
    Sale.all.select do |sale|
      sale.vendor_id == id
    end
  end

  def self.random
    all.sample
  end
end

#products by vendor
#compare revenues
#analyze sales (Like avg price?)

