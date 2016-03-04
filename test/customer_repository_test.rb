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

  def test_customer_repo_returns_all_matches_with_invoice_id
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_invoice_id(6)
    assert_equal [], customer
  end

  def test_customer_repo_returns_empty_array_with_wrong_invoice_id
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_invoice_id(2179)
    assert_equal [], customer
  end

  def test_it_returns_all_matching_credit_cards
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_credit_card_number(4177816490204479)
    answer = [3, 4, 2, 1]
    assert_equal answer, customer
  end

  def test_it_returns_nil_for_wrong_credit_card
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_credit_card_number(90209)
    assert_equal [], customer
  end

  def test_it_returns_all_by_result
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_result('pending')
    answer = [2, 3, 3, 2, 4]
    assert_equal answer, customer
  end

  def test_it_returns_empty_array_for_wrong_result
    skip
    c = CustomerRepository.new
    c.from_csv("./data/customers.csv")
    customer = c.find_all_by_result('watermelon')
    assert_equal [], customer
  end

end
