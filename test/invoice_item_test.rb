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

  def test_invoice_items_knows_its_attributes
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
   assert_equal 6, ii.id
   assert_equal 7, ii.item_id
   assert_equal 8, ii.invoice_id
   assert_equal 1, ii.quantity
   assert_equal 10.99, ii.unit_price.to_f
   assert_equal Time.now, ii.created_at
   assert_equal Time.now, ii.updated_at
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
