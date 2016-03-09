require 'pry'
require 'time'
require_relative "customer_repository"

class Merchant
  attr_accessor :id, :name, :created_at, :updated_at, :items, :item_count, :avg_item_price, :invoices, :invoice_count, :customer_ids

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @items = []
    @item_count = 0
    @customer_ids = []
  end

  def customers
    unless @customer_ids.empty?
      @customer_ids.map do |customer_id|
        c = @all_customers.find_with_id(customer_id)
      end
    end
    end

end
