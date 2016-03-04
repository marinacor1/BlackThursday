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

  def test_

end
