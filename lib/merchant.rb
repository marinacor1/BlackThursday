require 'pry'
require 'time'

class Merchant
  attr_accessor :id, :name, :created_at, :updated_at, :items, :item_count, :avg_item_price, :invoices, :invoice_count, :customers, :revenue, :invoice_items

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @items = []
    @item_count = 0
    @customers=[]
  end

  def revenue
    binding.pry
    revs = invoices.inject(0) do |invoice|
      invoice.
    end
  end



end
