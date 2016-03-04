require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require 'pry'

class TransactionTest < Minitest::Test
  def test_transaction_instantiates
    skip
    t = Transaction.new({
  :id => 6,
  :invoice_id => 8,
  :credit_card_number => "4242424242424242",
  :credit_card_expiration_date => "0220",
  :result => "success",
  :created_at => Time.now,
  :updated_at => Time.now
})
  end

  def test_transaction_knows_its_attributes
    skip
    t = Transaction.new({
  :id => 6,
  :invoice_id => 8,
  :credit_card_number => "4242424242424242",
  :credit_card_expiration_date => "0220",
  :result => "success",
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
