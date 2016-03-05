require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_invoice_repository_instantiates
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    assert se.invoices.instance_of? InvoiceRepository
  end

  def test_invoice_repository_contains_invoice_instances
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices.all
    assert ir[0].instance_of? Invoice
  end

  def test_all_returns_array_of_all_known_invoice_instances
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    ir = se.invoices.all
    assert_equal Array, ir.class
    assert_equal Invoice, ir[0].class
    assert_equal 4985, ir.count
  end

  def test_find_by_id_returns_correct_invoice
    i = Invoice.new({:id => 123, :name => "correct"})
    j = Invoice.new({:id => 456, :name => "incorrect"})
    data = []
    data << i
    data << j
    ir = InvoiceRepository.new(data)
    invoice = ir.find_by_id(123)

    assert_equal "correct", invoice.name
    assert_equal 123, invoice.id
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
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })
    se.repositories_linked

    merchant = se.merchants.find_by_id(12335938)
    invoice_array = merchant.invoices

    assert invoice_array.instance_of? Array
    assert invoice_array[0].instance_of? Invoice
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
