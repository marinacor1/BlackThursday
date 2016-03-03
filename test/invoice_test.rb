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


end
