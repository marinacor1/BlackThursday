require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item1, :invoice_item2, :invoice_item3, :ii, :invoice_items

  def setup
    invoice_item1 = InvoiceItem.new({id: 1, item_id: 10, invoice_id: 20, quantity: 2, unit_price: 13635, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    invoice_item2 = InvoiceItem.new({id: 2, item_id: 11, invoice_id: 20, quantity: 9, unit_price: 2196, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'})
    invoice_item3 = InvoiceItem.new({id: 3, item_id: 12, invoice_id: 21, quantity: 1, unit_price: 23324, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    invoice_item4 = InvoiceItem.new({id: 4, item_id: 13, invoice_id: 22, quantity: 1, unit_price: 79140, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'})

    @invoice_items = [invoice_item1, invoice_item2, invoice_item3, invoice_item4]

    @ii = InvoiceItemRepository.new(@invoice_items)
  end

  def test_invoice_item_repository_instantiates
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
    assert_equal 521.00, invoice_item.unit_price
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
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv'}
    se = SalesEngine.from_csv(hash)
    ii = se.invoice_items
    invoice_items = ii.find_all_by_invoice_id(2179337899)
    assert_equal [], invoice_items
  end
end
