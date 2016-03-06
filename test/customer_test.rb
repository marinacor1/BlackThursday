require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require 'pry'

class CustomerTest < Minitest::Test
  def test_customer_instantiates
    c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at  => "2015-03-13",
  :updated_at  => "2015-04-05",
})
    c.instance_of? Customer
  end

  def test_customer_knows_its_attributes
    c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at  => "2015-03-13",
  :updated_at  => "2015-04-05",
})
    assert_equal 6, c.id
    assert_equal "Joan", c.first_name
    assert_equal "Clarke", c.last_name
    assert_equal Time.parse("2015-03-13"), c.created_at
    assert_equal Time.parse("2015-04-05"), c.updated_at
  end



end
