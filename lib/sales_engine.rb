require 'pry'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
attr_reader :items, :merchants
def initialize
  @items = ItemRepository.new
  @merchants = MerchantRepository.new
end



end
