class Invoice
attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(attributes)
    @id = attributes[:id]
    @customer_id = attributes[:customer_id]
    @status = attributes[:status]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

end 
