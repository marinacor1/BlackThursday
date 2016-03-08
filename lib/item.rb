require 'bigdecimal'
require 'pry'
require 'time'

class Item
attr_accessor :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :merchant
  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = BigDecimal(attributes[:unit_price], 8)
    @merchant_id = attributes[:merchant_id]
    @created_at_time = attributes[:created_at]
    @updated_at_time = attributes[:updated_at]
    unit_price_to_dollars
  end

  def unit_price_to_dollars
    @unit_price = self.unit_price/100.0
  end

  def created_at
    Time.parse(@created_at_time)
  end

  def updated_at
    Time.parse(@updated_at_time)
  end

end

if __FILE__ == $0

  data = {
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99, 4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
  }
  item = Item.new(data)

end
