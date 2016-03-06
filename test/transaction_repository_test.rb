require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require 'pry'

class TransactionRepositoryTest < Minitest::Test
  def test_transaction_repo_instantiates
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    t = se.transactions
    t.instance_of? TransactionRepository
  end

  def test_transaction_repo_returns_all_instances
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    tr = se.transactions
    transaction = tr.all
    assert_equal 4985, transaction.count
  end

  def test_transaction_repo_returns_transaction_with_find_by_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    tr = se.transactions
    transaction = tr.find_by_id(6)
    assert_equal 4558368405929183, transaction.credit_card_number
    assert_equal 4966, transaction.invoice_id
    assert_equal "success", transaction.result
    assert_equal Transaction, transaction.class
  end

  def test_transaction_repo_returns_nil_with_wrong_find_by_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    tr = se.transactions
    transaction = tr.find_by_id(6798908090000000079968)
    assert_equal nil, transaction
  end

  def test_transaction_repo_returns_all_matches_with_invoice_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    tr = se.transactions
    transaction = tr.find_all_by_invoice_id(6)
    assert_equal Array, transaction.class
    assert_equal 4290398966064195, transaction[0].credit_card_number
    assert_equal "success", transaction[0].result
    assert_equal 2, transaction.count
  end

  def test_transaction_repo_returns_empty_array_with_wrong_invoice_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    tr = se.transactions
    transaction = tr.find_all_by_invoice_id(217000000937497349749237479)
    assert_equal [], transaction
  end

  def test_it_returns_all_matching_credit_cards
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    tr = se.transactions
    transaction = tr.find_all_by_credit_card_number(4068631943231473)
    assert_equal 4068631943231473, transaction[0].credit_card_number
    assert_equal Array, transaction.class
  end

  def test_it_returns_nil_for_wrong_credit_card
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => './data/invoices.csv', :invoice_items => './data/invoice_items.csv', :transactions => './data/transactions.csv'}
    se = SalesEngine.from_csv(hash)
    tr = se.transactions
    transaction = tr.find_all_by_credit_card_number(90209)
    assert_equal [], transaction
  end

  def test_it_returns_all_by_result
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_all_by_result('pending')
    answer = [2, 3, 3, 2, 4]
    assert_equal answer, transaction
  end

  def test_it_returns_empty_array_for_wrong_result
    skip
    tr = TransactionRepository.new
    tr.from_csv("./data/transactions.csv")
    transaction = tr.find_all_by_result('watermelon')
    assert_equal [], transaction
  end

end
