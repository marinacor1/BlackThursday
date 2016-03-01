require 'pry'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
attr_reader :items, :merchants
def initialize
  @items = ItemRepository.new
  @merchants = MerchantRepository.new
  load_items
  load_merchants
end

def load_items
end

def load_merchants
end

end
