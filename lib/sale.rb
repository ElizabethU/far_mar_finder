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
    CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

  def self.find(id_num)
    all.find do |sale|
      sale.id == id_num
    end
  end

  def self.find_by_vendor_id(vendor_id_num)
    all.find do |sale|
      sale.vendor_id == vendor_id_num
    end
  end

  def vendor
    Vendor.all.find do |vendor|
      vendor.id == vendor_id
    end
  end

  def product
    Product.all.find do |product|
      product.id == product_id
    end
  end

  def self.between(beginning_time, end_time)
    all.select do |sale|
      sale.purchase_time <= end_time && sale.purchase_time >= beginning_time
    end
  end

  # def self.find_all_by_amount(amount)
  #   all.select do ||
  #     market.city == city_name
end
