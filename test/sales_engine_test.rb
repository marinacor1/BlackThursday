require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_instantiates_with_repositories
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.new(hash)
    assert se.instance_of? SalesEngine
    assert se.items
    assert se.merchants
  end

  def test_sales_engine_carries_item_child_instance_for_item_repo
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.items.instance_of? ItemRepository
  end

  def test_sales_engine_carries_merchant_child_instance_for_merchant_repo
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.merchants.instance_of? MerchantRepository
  end

  def test_it_loads_items_and_merchants_from_csv
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert_equal 475 , se.merchants.count
    assert_equal 1367, se.items.count
  end

  def test_sales_engine_can_receive_information_from_many_csvs
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
      })
      assert se.items.instance_of? ItemRepository
      assert se.merchants.instance_of? MerchantRepository
      assert se.invoices.instance_of? InvoiceRepository
      assert se.invoice_items.instance_of? InvoiceItemRepository
      assert se.transactions.instance_of? TransactionRepository
      assert se.customers.instance_of? CustomerRepository
  end

def test_sales_engine_can_find_objects_associated_with_an_invoice
se = SalesEngine.from_csv({
:items => "./data/items.csv",
:merchants => "./data/merchants.csv",
:invoices => "./data/invoices.csv",
:invoice_items => "./data/invoice_items.csv",
:transactions => "./data/transactions.csv",
:customers => "./data/customers.csv"
})
customer_id = 9
query_id = 37
invoice = se.invoices.find_by_id(query_id)

assert_equal query_id, invoice.id
assert_equal customer_id, invoice.customer_id

transaction = se.transactions.find_by_id(37)
assert_equal 1301, transaction.invoice_id
end

def test_sales_engine_can_find_objects_associated_with_a_transaction
se = SalesEngine.from_csv({
:items => "./data/items.csv",
:merchants => "./data/merchants.csv",
:invoices => "./data/invoices.csv",
:invoice_items => "./data/invoice_items.csv",
:transactions => "./data/transactions.csv",
:customers => "./data/customers.csv"
})

invoice = se.invoices.find_by_id(40)
assert invoice.instance_of? Invoice
assert_equal 40, invoice.id
end

def test_sales_engine_can_find_mechants_from_invoices
skip
se = SalesEngine.from_csv({
  :items => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions => "./data/transactions.csv",
  :customers => "./data/customers.csv"
  })
  invoice = se.invoices.find_by_id(10)
  merchant = se.merchants.find_by_id(invoice.merchant_id)


  assert_equal customer_array, merchant.customers
end

def test_sales_engine_can_find_customers_from_merchant_side
  skip
  se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })
    customer = se.customers.find_by_id(30)
    merchants_array = ['m', 'm']
    assert_equal merchant_array, customer.merchants
    assert_equal MerchantRepository, merchants_array[0].class
  end

end
