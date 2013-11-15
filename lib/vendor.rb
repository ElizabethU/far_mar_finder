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

  def self.revenue(date)
    total_sales = 0
    Sale.by_date(date).each do |sale|
      total_sales += sale.amount
    end
    total_sales
  end

  def revenue(date=nil)
    total_sales = 0
    if date  
      #something else
      sales.each do |sale_instance|
        if sale_instance.purchase_time.strftime("%m/%d/%Y") == date
          total_sales += sale_instance.amount
        end
      end
    else
      sales.each do |sale|
        total_sales += sale.amount
      end
    end
    total_sales
  end

  def market
    @all_markets ||= Market.find(market_id)
  end

  def products
    @all_prods_by_vendor ||= Product.by_vendor(id)
  end

  def sales
    Sale.all.select do |sale|
      sale.vendor_id == id
    end
  end

  def self.random
    all.sample
  end
  
  def self.most_items(n)
    vendor_product_total_hash = {}
    all.each do |vendor| 
      vendor_product_total_hash[vendor] = vendor.products.length
    end
      vendor_product_total_hash.sort_by {|vendor, product_total| product_total}.reverse.take(n)
  end

  def self.best_day #Find the date with the highest revenue
    new_hash = {}
    @day_hash = all.group_by {|sale_instance| sale_instance.purchase_time.to_date }
    @day_hash.each do |date_object, sales_array|
      total_sales = 0
      all.select do |sale| #just sales for day
        sale.purchase_time.to_date == date_object
        total_sales += sale.amount
      end
      new_hash[date_object] = total_sales
    end
    new_hash.sort_by {|obj1, obj2| obj2 }.last
  end
end



