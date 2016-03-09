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
    self.invoices.map do |invoice|
      invoice.total if invoice.paid
    end.compact.inject(0, :+)

    # invoice_revenue = []
    # all_revenues = invoices.map do |invoice|
    #   if invoice.is_paid_in_full? && invoice.status != :returned
    #     invoice.invoice_items.each do |item|
    #       invoice_revenue << item.unit_price * item.quantity
    #     end
    #     invoice_revenue
    #   end
    # end
    # invoice_revenue.inject(:+)
  end


    def inspect
  "#<#{self.class}>"
end

end
