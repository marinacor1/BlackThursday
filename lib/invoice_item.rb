require 'pry'
require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :invoice_items, :invoice_items_count, :invoice

  def initialize(attributes)
    @id = attributes[:id].to_i
    @item_id = attributes[:item_id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @quantity = attributes[:quantity].to_i
    @unit_price = BigDecimal.new(attributes[:unit_price])
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @invoice_items = []
    @invoice_items_count = 0
  end

  def unit_price_to_dollars
    @unit_price/100.0 if @unit_price != nil
  end

  def unit_price
    unit_price_to_dollars
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

if __FILE__ == $0



end
