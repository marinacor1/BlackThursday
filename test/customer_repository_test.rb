require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer1, :customer2, :customer3, :cr, :customers

  def setup
    customer1 = Customer.new({id: 1, first_name: "Marina", last_name: "Corona", created_at: 10-20-1995, updated_at: 12-30-2013 })
    customer2 = Customer.new({id: 2, first_name: "Kami", last_name: "Boers", created_at: 11-20-1999, updated_at: 12-31-2015 })
    customer3 = Customer.new({id: 3, first_name: "Horace", last_name: "Williams", created_at: 01-15- 2000, updated_at: 02-30-2011 })
    customer4 = Customer.new({id: 3, first_name: "Horace", last_name: "Marks", created_at: 01-15- 2010, updated_at: 02-03-2011 })

    @customers = [customer1, customer2, customer3, customer4]

    @cr = CustomerRepository.new(@customers)
  end

  def test_customer_repo_instantiates
    cr.instance_of? CustomerRepository
  end

  def test_customer_repo_returns_all_instances
    customer = cr.all
    assert_equal 4, customer.count
  end

  def test_customer_repo_returns_customer_with_find_by_id
    answer = cr.find_by_id(1)
    assert_equal 'Marina', answer.first_name
    assert_equal 'Corona', answer.last_name
    assert_equal Customer, answer.class
  end

  def test_customer_repo_returns_nil_with_wrong_find_by_id
    assert_equal nil, cr.find_by_id(679879968)
  end

  def test_customer_repo_returns_all_matches_with_first_name
    answer = cr.find_all_by_first_name('Marina')
    assert_equal 'Marina', answer[0].first_name
    assert_equal 'Corona', answer[0].last_name
  end

  def test_customer_repo_returns_empty_array_with_wrong_first_name
    answer = cr.find_all_by_first_name('lollipops')
    assert_equal [], answer
  end

  def test_it_returns_all_matching_last_name_customers
    customer_names = cr.find_all_by_last_name('Williams')
    assert_equal 1, customer_names.count
    assert customer_names.all? {|name| name.last_name == 'Williams'}
  end

  def test_it_returns_empty_array_for_wrong_last_name
    all_names = cr.find_all_by_last_name('watermelon')
    assert_equal [], all_names
  end

end
