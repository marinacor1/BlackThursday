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
    skip
    c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at => Time.now,
  :updated_at => Time.now
})
    assert_equal 6, c.id
    assert_equal "Joan", c.first_name
    assert_equal "Clarke", c.last_name
    assert_equal Time.now, c.created_at
    assert_equal Time.now, c.updated_at
  end



end
