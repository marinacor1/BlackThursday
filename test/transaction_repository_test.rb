require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'
require 'pry'

class TranscactionRepositoryTest < Minitest::Test
  def test_transaction_repo_instantiates
    skip
    tr = TransactionRepository.new
    tr.instance_of? TransactionRepository
  end

  def test_transaction_repo_returns_all_instances
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.all
    assert_equal 53, transaction.count
  end

  def test_transaction_repo_returns_transaction_with_find_by_id
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_by_id(6)
    answer = 's'
    assert_equal answer, transaction
    assert_equal Transaction, answer.class
  end

  def test_transaction_repo_returns_nil_with_wrong_find_by_id
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_by_id(679879968)
    assert_equal nil, transaction
  end

  def test_transaction_repo_returns_all_matches_with_invoice_id
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_all_by_invoice_id(6)
    assert_equal [], transaction
  end

  def test_transaction_repo_returns_empty_array_with_wrong_invoice_id
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_all_by_invoice_id(2179)
    assert_equal [], transaction
  end

  def test_it_returns_all_matching_credit_cards
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_all_by_credit_card_number(4177816490204479)
    assert_equal [], transaction
  end

end
