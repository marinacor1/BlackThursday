require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_invoice_repository_instantiates
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
    assert_equal 4985, ir.all.count
  end

  def test_find_by_id_returns_correct_invoice
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    correct_invoice = ir.find_by_id(3451)
    assert_equal 12335337, correct_invoice.merchant_id
    assert_equal 679, correct_invoice.customer_id
    assert_equal 'returned', correct_invoice.status
    assert_equal Invoice, correct_invoice.class
  end

  def test_find_by_id_returns_nil_for_wrong_id
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    assert_equal nil, ir.find_by_id(1277777776)
  end

  def test_find_all_by_customer_id_returns_invoice_array
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    invoice_array = ir.find_all_by_customer_id(1)
    assert_equal 8, invoice_array.count
    assert_equal Array, invoice_array.class
    assert_equal Invoice, invoice_array[0].class
  end

  def test_find_all_by_customer_id_returns_empty_array_for_wrong_id
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    invoice_array =[]
    assert_equal invoice_array, ir.find_all_by_customer_id(1797294798)
    assert_equal Array, invoice_array.class
  end

  def test_all_by_status_returns_all_matching_status
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    status_array = ir.find_all_by_status('pending')
    assert_equal 1473, status_array.count
    assert_equal Array, status_array.class
  end

  def test_find_all_by_status_returns_empty_array_for_wrong_status
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices
    status_array = []
    assert_equal status_array, ir.find_all_by_status('popcorn')
    assert_equal Array, status_array.class
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
