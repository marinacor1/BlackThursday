class Invoice
attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :merchant, :customer, :items, :transactions
  def initialize(attributes)
    @id = attributes[:id]
    @customer_id = attributes[:customer_id]
    @merchant_id = attributes[:merchant_id]
    @status = attributes[:status].to_sym
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @items = []
    @transactions = []
  end

def all_transaction_status
  self.transactions.map do |transaction|
    transaction.result
  end
end

  def is_paid_in_full?
    array = all_transaction_status
    if array.include?("failed")
      return false
    else
      return true
    end
  end

  def total

  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end



end
