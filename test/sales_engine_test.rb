require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_instantiates_from_csv
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.instance_of? SalesEngine
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

  def test_sales_engine_can_find_connections_from_an_invoice
    skip
    se = SalesEngine.from_csv({
                              :items => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :transactions => "./data/transactions.csv",
                              :customers => "./data/customers.csv"
                            })
   invoice = se.invoices.find_by_id(20)
   invoice_items = ['i', 'i']
   assert_equal invoice_items, invoice.items
   transactions = ['t', 't']
   assert_equal transactions, invoice.transactions
   customer = 'person'
   assert_equal customer, invoice.customer
  end

  def test_sales_engine_can_find_connections_from_a_transaction
    skip
    se = SalesEngine.from_csv({
                              :items => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :transactions => "./data/transactions.csv",
                              :customers => "./data/customers.csv"
                              })
   transaction = se.invoices.find_by_id(40)
   invoice = 'invoice'
   assert_equal invoice, transaction.invoice
  end

  def test_sales_engine_can_find_mechants_from_customer_side
    skip
    se = SalesEngine.from_csv({
                              :items => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :transactions => "./data/transactions.csv",
                              :customers => "./data/customers.csv"
                              })
   merchant = se.invoices.find_by_id(10)
   customer_array = ['c', 'c']
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
