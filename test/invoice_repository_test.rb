require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_invoice_repository_instantiates
    binding.pry
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    se.invoices.instance_of? InvoiceRepository
  end

  def test_invoice_repository_contains_invoice_instances
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    ir.instance_of? InvoiceRepository
  end

  def test_all_returns_array_of_all_known_invoice_instances
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    assert_equal Array, ir.all.class
    assert_equal Invoice, ir.all[0].class
    assert_equal 4985, ir.count
  end

  def test_find_by_id_returns_correct_invoice
    skip
    ir = InvoiceRepository.new
    correct_invoice
    assert_equal correct_invoice, ir.find_by_id(12335938)
    assert_equal Invoice, correct_invoice.class
  end

  def test_find_by_id_returns_nil_for_wrong_id
    skip
    ir = InvoiceRepository.new
    assert_equal nil, ir.find_by_id(12)
  end

  def test_find_all_by_customer_id_returns_invoice_array
    skip
    ir = InvoiceRepository.new
    invoice_array =['invoice', 'invoice']
    assert_equal invoice_array, ir.find_all_by_customer_id(12335938)
    assert_equal Array, invoice_array.class
  end

  def test_find_all_by_customer_id_returns_empty_array_for_wrong_id
    skip
    ir = InvoiceRepository.new
    invoice_array =[]
    assert_equal invoice_array, ir.find_all_by_customer_id(18)
    assert_equal Array, invoice_array.class
  end

  def test_all_by_status_returns_all_matching_status
    skip
    ir = InvoiceRepository.new
    status_array = ['one', 'two']
    assert_equal status_array, ir.find_all_by_status('pending')
    assert_equal Array, ir.status_array.class
  end

  def test_find_all_by_status_returns_empty_array_for_wrong_status
    skip
    ir = InvoiceRepository.new
    status_array = []
    assert_equal status_array, ir.find_all_by_status('popcorn')
    assert_equal Array, ir.status_array.class
  end

  def test_merchants_have_invoices_relationship
    skip
    se = SalesEngine.from_csv({
:items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv"
      })
    merchant = se.merchants.find_by_id(12335938)
    invoice_array = ['i', 'i']
    assert_equal invoice_array, merchant.invoices
    assert_equal Array, invoice_array.class
  end

  def test_invoices_have_merchants_relationshp
    skip
    se = SalesEngine.from_csv({
:items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv"
      })
      invoice.se.invoices.find_by_id(12335938)
      assert_equal 'merchant', invoice.merchant
  end

end
