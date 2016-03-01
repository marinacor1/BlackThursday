require 'pry'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
attr_accessor :items, :merchants
def initialize

end

def self.from_csv(hash)

  items = ItemRepository.new
  items.populate_items_with_data_from_csv(hash[:items])
  @items = items
binding.pry
  # @merchants = MerchantRepository.new
  # @merchants.populate_items_with_data_from_csv(hash[:merchants])

  self

end


end

if __FILE__ == $0
se = SalesEngine.new
se = SalesEngine.from_csv({
  :items     => "../data/items.csv",
  :merchants => "../data/merchants.csv"
})
binding.pry
end
