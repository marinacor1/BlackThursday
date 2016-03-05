require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def test_customer_repo_instantiates
    skip
    c = CustomerRepository.new
    c.instance_of? CustomerRepository
  end

  def test_customer_repo_returns_all_instances
    skip
    c = CustomerRepository.new
    c.from_csv("./data/subsets/customers_small.csv")
    customer = c.all
    assert_equal 98, customer.count
  end

  def test_customer_repo_returns_customer_with_find_by_id
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_by_id(6)
    answer = 's'
    assert_equal answer, customer
    assert_equal Transaction, answer.class
  end

  def test_customer_repo_returns_nil_with_wrong_find_by_id
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_by_id(679879968)
    assert_equal nil, customer
  end

  def test_customer_repo_returns_all_matches_with_first_name
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_first_name('Mariah')
    assert_equal [], customer
  end

  def test_customer_repo_returns_empty_array_with_wrong_first_name
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_first_name('lollipops')
    assert_equal [], customer
  end

  def test_it_returns_all_matching_last_name_customers
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_last_name('Toy')
    answer = [3, 4, 2, 1]
    assert_equal answer, customer
  end


  def test_it_returns_empty_array_for_wrong_last_name
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_last_name('watermelon')
    assert_equal [], customer
  end

end
