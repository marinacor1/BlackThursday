require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_instantiates
    se = SalesEngine.new(nil)
    assert se.instance_of? SalesEngine
  end

  def test_sales_engine_forms_repositories_from_hash_of_data
    data =    ({:merchants => [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}],
    :items => [{:name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(200, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 390 },{:name => "Paper", :description => "You can write things on it", :unit_price  => BigDecimal.new(100, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 777 }] })

    se = SalesEngine.new(data)
    assert se.items
    assert se.merchants
    refute se.transactions
  end

  def test_sales_engine_carries_item_child_instance_for_item_repo
    data =    ({:merchants => [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}],
    :items => [{:name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(200, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 390 },{:name => "Paper", :description => "You can write things on it", :unit_price  => BigDecimal.new(100, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 777 }] })
    se = SalesEngine.new(data)
    assert se.items.instance_of? ItemRepository
    assert_equal 2, se.items.count
    assert se.items.all[0].instance_of? Item
  end

  def test_sales_engine_carries_merchant_child_instance_for_merchant_repo
    data =    ({:merchants => [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}],
    :items => [{:name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(200, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 390 },{:name => "Paper", :description => "You can write things on it", :unit_price  => BigDecimal.new(100, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 777 }] })

    se = SalesEngine.new(data)
    assert se.merchants.instance_of? MerchantRepository
    assert_equal 3, se.merchants.count
    assert se.merchants.all[0].instance_of? Merchant
  end

  def test_it_loads_items_and_merchants_from_csv
    hash = {:items => "./data/subsets/items_small.csv", :merchants => "./data/subsets/merchants_small.csv"}
    se = SalesEngine.from_csv(hash)
    assert_equal 3, se.merchants.count
    assert_equal 15, se.items.count
  end

  def test_sales_engine_can_receive_information_from_many_csvs
    se = SalesEngine.from_csv({
      :items => "./data/subsets/items_small.csv",
      :merchants => "./data/subsets/merchants_small.csv",
      :invoices => "./data/subsets/invoices_small.csv",
      :invoice_items => "./data/subsets/invoice_items_small.csv",
      :transactions => "./data/subsets/transactions_small.csv",
      :customers => "./data/subsets/customers_small.csv"
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
    :items => "./data/subsets/items_small.csv",
    :merchants => "./data/subsets/merchants_small.csv",
    :invoices => "./data/subsets/invoices_small.csv",
    :customers => "./data/subsets/customers_small.csv"})
    customer_id = 1
    query_id = 4
    invoice = se.invoices.find_by_id(query_id)

    assert_equal query_id, invoice.id
    assert_equal customer_id, invoice.customer_id
  end

  def test_sales_engine_can_find_objects_associated_with_a_transaction
    se = SalesEngine.from_csv({
      :items => "./data/subsets/items_small.csv",
      :merchants => "./data/subsets/merchants_small.csv",
      :invoices => "./data/subsets/invoices_small.csv"})
      invoice = se.invoices.find_by_id(9)
      assert invoice.instance_of? Invoice
      assert_equal 9, invoice.id
  end

  def test_merchants_have_invoices_relationship
    se = SalesEngine.from_csv({
                              :items => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                            })
    merchant = se.merchants.find_by_id(12334105)

    assert merchant.invoices.instance_of? Array
    assert_equal 10, merchant.invoice_count
  end

  def test_invoices_have_merchants_relationship
    se = SalesEngine.from_csv({
                                :items => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices => "./data/invoices.csv"
                              })
      invoice = se.invoices.find_by_id(3334)
      assert invoice.merchant.instance_of? Merchant
      assert_equal 12337321, invoice.merchant.id
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

  def test_sales_engine_can_find_mechants_from_invoices
    se = SalesEngine.from_csv({
      :items => "./data/subsets/items_small.csv",
      :merchants => "./data/subsets/merchants_small.csv",
      :invoices => "./data/subsets/invoices_small.csv"})
      invoice = se.invoices.find_by_id(3)
      merchant = se.merchants.find_by_id(invoice.merchant_id)
      assert_equal invoice.merchant_id, merchant.id
  end

  def test_sales_engine_can_link_merchants_and_customers_through_invoices
    se = SalesEngine.from_csv({
    :items => "./data/subsets/items_small.csv",
    :merchants => "./data/subsets/merchants_small.csv",
    :invoices => "./data/subsets/invoices_small.csv",
    :customers => "./data/subsets/customers_small.csv",
    :transactions => "./data/subsets/transactions_small.csv",
    :invoice_items => "./data/subsets/invoice_items_small.csv"})

    invoice = se.invoices.all[8]
    invoice_customer = invoice.customer
    invoice_merchant = invoice.merchant

    assert_equal invoice_customer, se.customers.find_by_id(invoice.customer_id)
    assert_equal invoice_merchant, se.merchants.find_by_id(invoice.merchant_id)

    assert invoice_merchant.customers.include?(invoice_customer)
    assert invoice_merchant.customers.instance_of? Array
    assert invoice_merchant.customers[0].instance_of? Customer
  end
end
