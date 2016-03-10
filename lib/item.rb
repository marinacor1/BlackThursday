require 'bigdecimal'
require 'pry'
require 'time'

class Item
  attr_accessor :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :merchant
  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = BigDecimal(attributes[:unit_price])
    @merchant_id = attributes[:merchant_id].to_i
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    unit_price_to_dollars
  end

  def unit_price_to_dollars
    @unit_price = self.unit_price/100.0
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def inspect
    "#<#{self.class}>"
  end

end
