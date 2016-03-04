require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require 'pry'

class InvoiceItemTest < Minitest::Test
  def test_invoice_items_instantiates
    skip
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal.new(10.99, 4),
  :created_at => Time.now,
  :updated_at => Time.now
})
   assert ii.instance_of? InvoiceItem 
  end

end
