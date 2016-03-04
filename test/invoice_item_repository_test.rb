require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_invoice_repo_can_find_invoice_with_item_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice = ir.find_by_id(6)
    assert_equal 'invoice', invoice
    assert_equal Invoice, invoice[0].class
  end

  def test_invoice_repo_can_find_all_invoices_with_item_id
    skip
    ir = InvoiceItemRepository.new
    ir.from_csv("./data/invoice_items.csv")
    invoice = ir.find_by_id(6)
    assert_equal 'invoice', invoice
    assert_equal Invoice, invoice[0].class
  end
end 
