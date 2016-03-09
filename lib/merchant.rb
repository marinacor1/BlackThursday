require 'pry'
require 'time'

class Merchant
  attr_accessor :id, :name, :created_at, :updated_at, :items, :item_count, :avg_item_price, :invoices, :invoice_count, :customers, :revenue

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @items = []
    @item_count = 0
    @customers=[]
  end

  def total_revenue
    invoice_items.map do |item|
      item.unit_price * item.quantity
    end
  end



end
