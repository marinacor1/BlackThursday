require 'pry'
require 'time'

class Transaction
  attr_accessor :id, :invoice_id, :credit_card_number,
  :credit_card_expiration_date, :result, :created_at, :updated_at, :invoice

  def initialize(attributes)
    @id = attributes[:id]
    @invoice_id = attributes[:invoice_id]
    @credit_card_number = attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result = attributes[:result]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @invoice = nil
  end

def created_at
  Time.parse(@created_at)
end

def updated_at
  Time.parse(@updated_at)
end

end
