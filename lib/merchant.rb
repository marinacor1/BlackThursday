require 'pry'

class Merchant
  attr_accessor :id, :name, :created_at, :updated_at, :items, :item_count

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
    @items = []
    @item_count = 0
  end

end

if __FILE__ == $0
  m = Merchant.new({:id => 5, :name => "Turing School"})
end
