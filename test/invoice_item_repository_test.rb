require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_invoice_item_repository_instantiates
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    assert ii.instance_of? InvoiceItemRepository
  end

  def test_invoice_item_repo_returns_all_instances
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    invoices = ii.all
    assert_equal 21830, invoices.count
    assert_equal InvoiceItem, invoices[0].class
  end

  def test_invoice_repo_can_find_invoice_with_item_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    invoice_item = ii.find_by_id(6)
    assert_equal 263539664, invoice_item.item_id
    assert_equal 52100, invoice_item.unit_price
    assert_equal InvoiceItem, invoice_item.class
  end

  def test_invoice_repo_returns_nil_if_find_by_id_has_wrong_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    invoice_item = ii.find_by_id(678098908045)
    assert_equal nil, invoice_item
  end

  def test_invoice_repo_gives_all_matching_items_by_find_all_by_item_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    invoice_items = ii.find_all_by_item_id(263539664)
    assert_equal 23, invoice_items.count
    assert_equal InvoiceItem, invoice_items[0].class
  end

  def test_invoice_repo_gives_nil_if_by_find_all_by_item_id_has_wrong_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    invoice_items = ii.find_all_by_item_id(787707077797987)
    assert_equal [], invoice_items
  end

  def test_find_all_by_invoice_id_returns_array_of_invoices
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    invoice_items = ii.find_all_by_invoice_id(2)
    array = ['1', '2']
    assert_equal 4, invoice_items.count 
    assert_equal InvoiceItem, invoice_items[0].class
  end

  def test_find_all_by_invoice_id_returns_empty_array_for_wrong_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice_items = ir.find_all_by_invoice_id(21797899)
    assert_equal [], invoice_items
    assert_equal InvoiceItem, invoice_items[0].class
  end
end
