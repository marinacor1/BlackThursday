require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice1, :invoice2, :invoice3, :invoice4, :ir, :invoices

  def setup
    invoice1 = {id: 20, customer_id: 10, merchant_id: 100, status: 'shipped', created_at: 10-20-1995, updated_at: 12-18-2013 }
    invoice2 = {id: 21, customer_id: 11, merchant_id: 101, status: 'shipped', created_at: 11-20-1995, updated_at: 02-30-1009 }
    invoice3 = {id: 22, customer_id: 11, merchant_id: 100, status: 'pending', created_at: 10-20-1985, updated_at: 01-13-2013 }
    invoice4 = {id: 23, customer_id: 11, merchant_id: 102, status: 'shipped', created_at: 12-21-1975, updated_at: 12-30-2015 }

    @invoices = [invoice1, invoice2, invoice3, invoice4]

    @ir = InvoiceRepository.new
    @ir.from_array(@invoices)
  end

  def test_invoice_repository_instantiates
    ir.instance_of? InvoiceRepository
  end

  def test_all_returns_array_of_all_known_invoice_instances
    assert_equal Array, ir.all.class
    assert_equal Invoice, ir.all[0].class
    assert_equal 4, ir.all.count
  end

  def test_find_by_id_returns_correct_invoice
    correct_invoice = ir.find_by_id(20)
    assert_equal 100, correct_invoice.merchant_id
    assert_equal 10, correct_invoice.customer_id
    assert_equal :shipped, correct_invoice.status
    assert_equal Invoice, correct_invoice.class
  end

  def test_find_by_id_returns_nil_for_wrong_id
    assert_equal nil, ir.find_by_id(1277777776)
  end

  def test_find_all_by_customer_id_returns_invoice_array
    invoice_array = ir.find_all_by_customer_id(11)
    assert_equal 3, invoice_array.count
    assert_equal Array, invoice_array.class
    assert_equal Invoice, invoice_array[0].class
  end

  def test_find_all_by_customer_id_returns_empty_array_for_wrong_id
    invoice_array =[]
    assert_equal invoice_array, ir.find_all_by_customer_id(1880)
    assert_equal Array, invoice_array.class
  end

  def test_all_by_status_returns_all_matching_status
    status_array = ir.find_all_by_status('pending')
    assert_equal 1, status_array.count
    assert_equal Array, status_array.class
  end

  def test_find_all_by_status_returns_empty_array_for_wrong_status
    status_array = []
    assert_equal status_array, ir.find_all_by_status('popcorn')
    assert_equal Array, status_array.class
  end


end
