require_relative 'transaction'
require 'pry'
require 'csv'
class TransactionRepository
  def inspect
    true
  end

  attr_accessor :all, :name

  def initialize(path)
    @all_transactions = []
    populate_transaction_repo(path)
  end

  def populate_transaction_repo(path)
    if path.include? '.csv'
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      transaction = Transaction.new(data_row)
      @all_transactions << transaction
    end
    else
      populate_transaction_repo_with_hash(path)
    end
  end

  def populate_transaction_repo_with_hash(path)
      path.each do
      transaction = Transaction.new(path)
      @all_transactions << transaction
    end
  end

  def all
    @all_transactions
  end

  def count
    @all_transactions.count
  end

  def find_by_id(id_query)
    @all_transactions.find do |element|
      id_query == element.id
    end
  end

  def find_all_by_invoice_id(id)
    @all_transactions.find_all do |invoice|
      invoice.invoice_id == id
    end
  end

  def find_all_by_result(status)
    #returns [] or matches with matching cc number
  end




end
