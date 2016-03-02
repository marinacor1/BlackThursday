require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @merchants = merchant_items_assigned_by_id(@merchants)
  end

  def merchant_items_assigned_by_id(merchants)
     merchants.all.map do |merchant|
      merchant.items = @items.find_all_by_merchant_id(merchant.id)
      merchant.item_count = merchant.items.count
      merchant
    end
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
    # binding.pry
  end
