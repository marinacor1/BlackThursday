require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction1, :transaction2, :transaction3, :tr, :transactions

  def setup
    transaction1 = Transaction.new({id: 1, invoice_id: 10, credit_card_number: 2020202020, credit_card_expiration_date: 0217, result: 'success', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    transaction2 = Transaction.new({id: 2, invoice_id: 11, credit_card_number: 2121212121, credit_card_expiration_date: 1220, result: 'failed', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    transaction3 = Transaction.new({id: 3, invoice_id: 12, credit_card_number: 2222222222, credit_card_expiration_date: 1118, result: 'success', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    transaction4 = Transaction.new({id: 4, invoice_id: 13, credit_card_number: 2222222222, credit_card_expiration_date: 1118, result: 'failed', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })

    @transactions = [transaction1, transaction2, transaction3, transaction4]

    @tr = TransactionRepository.new(@transactions)
  end

  def test_transaction_repo_instantiates
    tr.instance_of? TransactionRepository
  end

  def test_transaction_repo_returns_all_instances
    transaction = tr.all
    assert_equal 4, transaction.count
  end

  def test_transaction_repo_returns_transaction_with_find_by_id
    transaction = tr.find_by_id(1)
    assert_equal 2020202020, transaction.credit_card_number
    assert_equal 10, transaction.invoice_id
    assert_equal "success", transaction.result
    assert_equal Transaction, transaction.class
  end

  def test_transaction_repo_returns_nil_with_wrong_find_by_id
    transaction = tr.find_by_id(6798908090000000079968)
    assert_equal nil, transaction
  end

  def test_transaction_repo_returns_all_matches_with_invoice_id
    transaction = tr.find_all_by_invoice_id(11)
    assert_equal Array, transaction.class
    assert_equal 2121212121, transaction[0].credit_card_number
    assert_equal "failed", transaction[0].result
    assert_equal 1, transaction.count
  end

  def test_transaction_repo_returns_empty_array_with_wrong_invoice_id
    transaction = tr.find_all_by_invoice_id(217000000937497349749237479)
    assert_equal [], transaction
  end

  def test_it_returns_all_matching_credit_cards
    transaction = tr.find_all_by_credit_card_number(2222222222)
    assert_equal 2222222222, transaction[0].credit_card_number
    assert_equal Array, transaction.class
    assert_equal 2, transaction.count
  end

  def test_it_returns_nil_for_wrong_credit_card
    transaction = tr.find_all_by_credit_card_number(90209)
    assert_equal [], transaction
  end

  def test_it_returns_all_by_result
    transaction = tr.find_all_by_result('failed')
    assert_equal Array, transaction.class
    assert_equal 2, transaction.count
  end

  def test_it_returns_empty_array_for_wrong_result
    transaction = tr.find_all_by_result('watermelon')
    assert_equal [], transaction
  end

end
