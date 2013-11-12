class Sale
  attr_reader :name, :amount, :purchase_time, :vendor_id, :product_id

  def initialize(array)
    @id = array[0]
    @amount = array[1] #to float?
    @purchase_time = array[2]
    @vendor_id = array[3]
    @product_id = array[4]
  end

  def self.all
    CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

  def self.find(id_num)
    all.find do |sale|
      sale.id.to_i == id_num
    end
  end

  def self.find_by_vendor_id(vendor_id_num)
    all.find do |sale|
      sale.vendor_id == vendor_id_num
    end
  end

  # def self.find_all_by_amount(amount)
  #   all.select do ||
  #     market.city == city_name
    end
  end
end
