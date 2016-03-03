require 'pry'

class Merchant
  attr_accessor :id, :name, :created_at, :updated_at, :items, :item_count, :avg_item_price

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @items = []
    @item_count = 0
  end

end
