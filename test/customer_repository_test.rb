require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def test_customer_repo_instantiates
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    c.instance_of? CustomerRepository
  end

  def test_customer_repo_returns_all_instances
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    customer = c.customers.all
    assert_equal 1000, customer.count
  end

  def test_customer_repo_returns_customer_with_find_by_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    customer = c.customers
    answer = customer.find_by_id(6)
    assert_equal 'Heber', answer.first_name
    assert_equal 'Kuhn', answer.last_name
    assert_equal Customer, answer.class
  end

  def test_customer_repo_returns_nil_with_wrong_find_by_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    customer = c.customers
    assert_equal nil, customer.find_by_id(679879968)
  end

  def test_customer_repo_returns_all_matches_with_first_name
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    customer = c.customers
    answer = customer.find_all_by_first_name('Mariah')
    assert_equal 'Mariah', answer[0].first_name
    assert_equal 'Toy', answer[0].last_name
  end

  def test_customer_repo_returns_empty_array_with_wrong_first_name
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    customer = c.customers
    answer = customer.find_all_by_first_name('lollipops')
    assert_equal [], answer
  end

  def test_it_returns_all_matching_last_name_customers
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    customer = c.customers
    customer_names = customer.find_all_by_last_name('Toy')
    assert_equal 2, customer_names.count
    assert customer_names.all? {|name| name.last_name == 'Toy'}
  end

  def test_it_returns_empty_array_for_wrong_last_name
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :customers => './data/customers.csv'}
    c = SalesEngine.from_csv(hash)
    customer = c.customers
    all_names = customer.find_all_by_last_name('watermelon')
    assert_equal [], all_names
  end

end
