class Product
  attr_reader :id, :name, :vendor_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @vendor_id = array[2].to_i
  end

  def self.all
    @all_product ||= CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

  def self.find(id_num)
    all.find do |product|
      product.id == id_num
    end
  end

  def self.by_vendor(vendor_id_num)
    all.find do |product|
      product.vendor_id == vendor_id_num
    end
  end

  def self.find_by_name(name_ven)
    all.select do |product|
      product.name =~ /#{name_ven}/i
    end
  end

  def self.by_vendor(id_of_vendor)
    all.select do |product|
      product.vendor_id ==  id_of_vendor
    end
  end

  def vendor
    Vendor.all.find do |vendor|
      vendor.id == vendor_id
    end
  end

  def sales
    Sale.all.select do |sale|
      sale.product_id == id
    end
  end

  def number_of_sales
    count = 0
    sales.each do |sale|
      count += 1
    end
    return count
  end

  def self.random
    all.sample
  end

  def self.most_revenue(n)
    array_of_product_objects = []
    product_and_total_rev_hash = {}
    Sale.all.each do |sale_instance|
      if product_and_total_rev_hash[sale_instance.product_id]
        product_and_total_rev_hash[sale_instance.product_id] += sale_instance.amount
      else
        product_and_total_rev_hash[sale_instance.product_id] = sale_instance.amount
      end
    end
    top_products_array = product_and_total_rev_hash.sort_by {|product_id, revenue| revenue }.reverse.take(n)
    top_products_array.each do |product_sub_array|
      array_of_product_objects << Product.find(product_sub_array[0])
    end
    array_of_product_objects
  end
end

