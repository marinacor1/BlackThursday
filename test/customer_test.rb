require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require 'pry'

class CustomerTest < Minitest::Test
  def test_customer_instantiates
    skip
    t = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at => Time.now,
  :updated_at => Time.now
})
    t.instance_of? Customer
  end

  def test_customer_knows_its_attributes
    skip
    t = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at => Time.now,
  :updated_at => Time.now
})
    assert_equal 6, t.id
    assert_equal 8, t.invoice_id
    assert_equal "4242424242424242", t.credit_card_number
    assert_equal "0220", t.credit_card_expiration_date
    assert_equal "success", t.result
    assert_equal Time.now, t.created_at
    assert_equal Time.now, t.updated_at
  end



end
