class Product
  # attr_reader :name, :address #etc

  def initialize(array)
    @id = array[0]
    @name = array[1]
    @vendor_id = array[2]
  end

  def self.all
    CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

  def self.find(id_num)
    all.find do |product|
      product.id.to_i == id_num
    end
  end

  def self.find_by_vendor_id(vendor_id_num)
    all.find do |product|
      product.vendor_id.to_i == vendor_id_num
    end
  end

  def self.find_by_name(name_ven)
    all.select do |product|
      product.name =~ /#{name_ven}/i
    end
  end

  

end

