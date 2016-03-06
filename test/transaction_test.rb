require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require 'pry'

class TransactionTest < Minitest::Test
  def test_transaction_instantiates
    t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at  => "2015-03-13",
                          :updated_at  => "2015-04-05",
                        })
    t.instance_of? Transaction
  end

  def test_transaction_knows_its_attributes
    t = Transaction.new({
                        :id => 6,
                        :invoice_id => 8,
                        :credit_card_number => "4242424242424242",
                        :credit_card_expiration_date => "0220",
                        :result => "success",
                        :created_at  => "2015-03-13",
                        :updated_at  => "2015-04-05",
                      })
    assert_equal 6, t.id
    assert_equal 8, t.invoice_id
    assert_equal "4242424242424242", t.credit_card_number
    assert_equal "0220", t.credit_card_expiration_date
    assert_equal "success", t.result
    assert_equal "2015-03-13", t.created_at
    assert_equal "2015-04-05", t.updated_at
  end

  def test_transaction_returns_data_in_string_format
        t = Transaction.new({
                            :id => 6,
                            :invoice_id => 8,
                            :credit_card_number => "4242424242424242",
                            :credit_card_expiration_date => "0210",
                            :result => "success",
                            :created_at  => "2015-03-13",
                            :updated_at  => "2015-04-05",
                          })
        assert_equal 6, t.id
        assert_equal 8, t.invoice_id
        assert_equal "4242424242424242", t.credit_card_number
        assert_equal "0210", t.credit_card_expiration_date
        assert_equal String, t.credit_card_expiration_date.class
        assert_equal "success", t.result
        assert_equal "2015-03-13", t.created_at
        assert_equal "2015-04-05", t.updated_at
      end


end
