require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_invoice_item_repository_instantiates
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    assert ir.instance_of? InvoiceItemRepository
  end

  def test_invoice_item_repo_returns_all_instances
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/subsets/invoice_items_small.csv")
    invoices = ir.all
    assert_equal 10, invoices.count
    assert_equal Invoice, invoices[0].class
  end

  def test_invoice_repo_can_find_invoice_with_item_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice = ir.find_by_id(6)
    assert_equal 'invoice', invoice
    assert_equal Invoice, invoice[0].class
  end

  def test_invoice_repo_returns_nil_if_find_by_id_has_wrong_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice = ir.find_by_id(6745)
    assert_equal nil, invoice
  end
end
