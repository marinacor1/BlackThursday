require 'pry'
require 'csv'
require_relative 'item'

class ItemRepository
  attr_accessor :data

def initialize

end

def populate_items_with_data_from_csv(path)
@data = []
CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |row|

  i = Item.new
  i.id = row[:id]
  i.name = row[:name]
  i.description = row[:description]
  i.unit_price = row[:unit_price]
  i.merchant_id = row[:merchant_id]
  i.created_at = row[:created_at]
  i.updated_at = row[:updated_at]
  @data << i

end

binding.pry
end



end


if __FILE__ == $0

item_repo = ItemRepository.new("../data/items.csv")

end
