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
    assert_equal InvoiceItem, invoices[0].class
  end

  def test_invoice_repo_can_find_invoice_with_item_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice_item = ir.find_by_id(6)
    assert_equal 'invoice', invoice_item
    assert_equal InvoiceItem, invoice_item[0].class
  end

  def test_invoice_repo_returns_nil_if_find_by_id_has_wrong_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice_item = ir.find_by_id(6745)
    assert_equal nil, invoice_item
  end

  def test_invoice_repo_gives_all_matching_items_by_find_all_by_item_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice_items = ir.find_all_by_item_id(7)
    assert_equal [], invoice_items
    assert_equal InvoiceItem, invoice_items.class
  end

  def test_invoice_repo_gives_nil_if_by_find_all_by_item_id_has_wrong_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice_items = ir.find_all_by_item_id(787787)
    assert_equal nil, invoice_items
  end

end
