require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'pry'

class InvoiceTest < Minitest::Test

  def test_invoice_class_instantiates
    skip
    i = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now,
  :updated_at  => Time.now,
})
    i.instance_of? Invoice
  end

  def test_invoice_knows_its_information
    skip
  i = Invoice.new({
:id          => 6,
:customer_id => 7,
:merchant_id => 8,
:status      => "pending",
:created_at  => Time.now,
:updated_at  => Time.now,
})
  assert_equal 6, i.id
  assert_equal 7, i.customer_id
  assert_equal "pending", i.status
  assert_equal Time.now, i.created_at
  assert_equal Time.now, i.updated_at
  end

  def test_invoice_can_tell_if_paid_in_full
    skip
        i = Invoice.new({
      :id          => 4126,
      :customer_id => 817,
      :merchant_id => 12336248,
      :status      => "shipped",
      :created_at  => '2011-08-16',
      :updated_at  =>'2012-03-29',
    })
    #i think that we have to do something like this
    #i might be wrong
    assert invoice.is_paid_in_full?
  end

  def test_invoice_can_tell_if_not_paid_in_full
    skip
        i = Invoice.new({
      :id          => 3792,
      :customer_id => 754,
      :merchant_id => 12335541,
      :status      => "shipped",
      :created_at  => '2005-07-21',
      :updated_at  =>'2014-08-22',
    })
    #i think that we have to do something like this
    #connect with transaction and find that it is pending
    refute invoice.is_paid_in_full?
  end

end
