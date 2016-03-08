require_relative 'transaction'
require_relative 'sales_engine'
require 'pry'
require 'csv'


class TransactionRepository


  def inspect
    "#<#{self.class}>"
  end

  attr_accessor :all, :name

  def initialize
    @all_transactions = []
  end

  def from_csv(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol}) do |data_row|
      transaction = Transaction.new(data_row)
      @all_transactions << transaction
    end
  end

  def from_array(array)
    array.each do |attributes|
      transaction = Transaction.new(attributes)
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

  def find_all_by_result(result)
    @all_transactions.select do |element|
       element.result.downcase == result ? element : nil
    end
  end

  def find_all_by_credit_card_number(cc_query)
    @all_transactions.select do |element|
      element.credit_card_number == cc_query
    end
  end


end

if __FILE__ == $0
transaction = TransactionRepository.new
transaction.from_csv("./data/transactions.csv")

  binding.pry
engine.transactions.find_all_by_credit_card_number(4848466917766329)
expect(expected.length).to eq 1
expect(expected.first.class).to eq Transaction
expect(expected.first.credit_card_number).to eq credit_card_number

credit_card_number = 4848466917766328
expected = engine.transactions.find_all_by_credit_card_number(credit_card_number)
end
