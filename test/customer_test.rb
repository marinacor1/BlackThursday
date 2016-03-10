require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require 'pry'

class CustomerTest < Minitest::Test
  def test_customer_instantiates
    c = Customer.new({:id => 6,})
    c.instance_of? Customer
  end

  def test_customer_knows_its_attributes
    c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at  => "2007-06-04 21:35:10 UTC",
  :updated_at  => "2015-10-12 21:35:10 UTC",
})
    assert_equal 6, c.id
    assert_equal "Joan", c.first_name
    assert_equal "Clarke", c.last_name
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), c.created_at
    assert_equal Time.parse("2015-10-12 21:35:10 UTC"), c.updated_at
  end



end
