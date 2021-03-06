class Sale
  attr_reader :name, :amount, :purchase_time, :vendor_id, :product_id, :id

  def initialize(array)
    @id = array[0].to_i
    @amount = array[1].to_i
    @purchase_time = Time.parse(array[2])
    @vendor_id = array[3].to_i
    @product_id = array[4].to_i
  end

  def self.all
    @all_sale ||= CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

  def self.find(id_num)
    all.find do |sale|
      sale.id == id_num
    end
  end

  def self.find_by_vendor_id(vendor_id_num)
    all.select do |sale|
      sale.vendor_id == vendor_id_num
    end
  end

  def self.by_amount(amount)
    all.select do |sale_instance|
      sale_instance.amount = amount
    end
  end

  def self.by_date(date)
    all.select do |sale_instance|
      sale_instance.purchase_time.strftime("%m/%d/%Y") == date
    end
  end

  def by_date(date)
    Sale.all.select do |sale_instance|
      sale_instance.purchase_time.strftime("%m/%d/%Y") == date
    end
  end

  def vendor
    Vendor.find(id)
  end

  def product
    Product.find(id)
  end

  def self.between(beginning_time, end_time)
    all.select do |sale|
      sale.purchase_time <= end_time && sale.purchase_time >= beginning_time
    end
  end

  def self.random
    all.sample
  end

  def self.best_day
    #Interpretted as the date with the highest revenue, not most sales objects
    new_hash = {}
    @day_hash = all.group_by {|sale_instance| sale_instance.purchase_time.to_date }
    @day_hash.each do |date_object, sales_array|
      total_sales = 0
      sales_array.select do |sale| #just sales for day
        sale.purchase_time.to_date == date_object
        total_sales += sale.amount
      end
      new_hash[date_object] = total_sales
    end
    new_hash.sort_by {|obj1, obj2| obj2 }.last[0]
  end
end
