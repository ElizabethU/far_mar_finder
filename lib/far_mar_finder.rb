require 'csv'
require 'time'
require 'colorize'
require_relative 'vendor'
require_relative 'sale'
require_relative 'market'
require_relative 'product'
# ... Require all of the supporting classes

class FarMarFinder
  def initialize
  end

  def markets
    Market
  end

  def vendors
    Vendor
  end

  def products
    Product
  end

  def sales
    Sale
  end

end