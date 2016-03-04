class Invoice
attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :merchant
  def initialize(attributes)
    @id = attributes[:id]
    @customer_id = attributes[:customer_id]
    @merchant_id = attributes[:merchant_id]
    @status = attributes[:status]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def is_paid_in_full?
    #returns ture if invoice is paid in full
  end

  def total
    #returns total $ amount of invoice
  end

end
