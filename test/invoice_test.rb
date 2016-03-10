require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'pry'
require_relative '../lib/transaction'

class InvoiceTest < Minitest::Test

  def test_invoice_class_instantiates
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
                  :customer_id => 1,
                  :merchant_id => 12334389,
                  :status      => "pending",
                  :created_at  => "2015-03-13",
                  :updated_at  => "2015-04-05",
                  })
  assert_equal 6, i.id
  assert_equal 1, i.customer_id
  assert_equal :pending, i.status
  assert_equal Time.parse("2015-03-13"), i.created_at
  assert_equal Time.parse("2015-04-05"), i.updated_at
  end

  def test_invoice_can_tell_if_paid_in_full
    transaction1 = Transaction.new({ :id => 1, :result => "success" })
    transaction2 = Transaction.new({ :id => 2, :result => "success" })
    i = Invoice.new({ :id => 123, :transactions => [] })
    i.transactions << transaction1
    i.transactions << transaction2
    assert i.is_paid_in_full?
  end

  def test_invoice_can_tell_if_not_paid_in_full
    transaction1 = Transaction.new({ :id => 1, :result => "failed" })
    transaction2 = Transaction.new({ :id => 2, :result => "failed" })
    i = Invoice.new({ :id => 123, :transactions => [] })
    i.transactions << transaction1
    i.transactions << transaction2
    refute i.is_paid_in_full?
  end

end
