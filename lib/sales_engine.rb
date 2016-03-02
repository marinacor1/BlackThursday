require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants, :merchant

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @items.all = @merchants.merchants_and_items_linked(@items)
  end

  def self.from_csv(data)
    all_instances = self.new(data)
  end


end

if __FILE__ == $0

  se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    binding.pry
end
