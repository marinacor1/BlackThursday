require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/invoice_item'
require 'pry'
require 'time'

class InvoiceItemTest < Minitest::Test
  def test_invoice_items_instantiates
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

  def test_invoice_items_knows_its_attributes
    ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal.new(10.99, 4),
  :created_at => "2015-03-13",
  :updated_at => "2015-04-13"
})
   assert_equal 6, ii.id
   assert_equal 7, ii.item_id
   assert_equal 8, ii.invoice_id
   assert_equal 1, ii.quantity
   assert_equal 0.1099, ii.unit_price.to_f
   assert_equal Time.parse("2015-03-13"), ii.created_at
   assert_equal Time.parse("2015-04-13"), ii.updated_at
  end

  def test_it_returns_unit_price_to_dollars
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
    answer = 244
    assert_equal answer, ii.unit_price_to_dollars
    assert_equal Float, answer.class
  end
end
