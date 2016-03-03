require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    repositories_linked
  end

  def repositories_linked
    merchants_linked_to_child_items
    items_linked_to_parent_merchant
  end

  def merchants_linked_to_child_items
    @merchants.all.map do |merchant|
      merchant.items = @items.find_all_by_merchant_id(merchant.id)
      merchant.item_count = merchant.items.count
      merchant
    end
  end

  def items_linked_to_parent_merchant
    @items.all.map do |item|
      item.merchant = @merchants.find_by_id(item.merchant_id)
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

    binding.pry
  end
