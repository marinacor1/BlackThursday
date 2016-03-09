require 'pry'
require 'time'
require_relative 'merchant_repository'

class Customer
  attr_accessor :id, :first_name, :last_name, :created_at, :updated_at, :merchant_ids, :invoices

  def initialize(attributes)
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @merchant_ids = []
    @invoices = []
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchants
    unless @merchant_ids.empty?
    @merchant_ids.each do |merch_id|
      merchant = @all_merchants.find_with_id(merch_id)
    end
  end
  end

end

if __FILE__ == $0
  c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at  => "2007-06-04 21:35:10 UTC",
  :updated_at  => "2015-10-12 21:35:10 UTC",
  })

binding.pry
end
