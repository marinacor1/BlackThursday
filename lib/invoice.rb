require 'pry'
require 'time'

class Invoice
attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :merchant, :customer, :items, :transactions, :total, :invoice_items, :paid
  def initialize(attributes)
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @items = []
    @transactions = []
    @invoice_items = []
    @paid = true
  end

  def is_paid_in_full?
    array = all_transaction_status
    if array.include?("failed") || array.empty?
      return false
      @paid = false
    else
      return true
      @paid = true
    end
  end

  def is_pending?
    transactions.all? do |transaction|
      transaction.result == "failed"
    end
  end


  def status
    @status.to_sym
  end

  def all_transaction_status
    self.transactions.map do |transaction|
      transaction.result
    end
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def inspect
    "#<#{self.class}>"
  end

end
