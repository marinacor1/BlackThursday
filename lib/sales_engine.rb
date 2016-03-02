require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
<<<<<<< HEAD
    merchant_items_assigned_by_id
=======
    @items.all = @merchants.merchants_and_items_linked(@items)
>>>>>>> 0978c987354224fa810cb1da0b0c0341834ada13
  end

  def self.from_csv(data)
    all_instances = self.new(data)
  end

<<<<<<< HEAD
=======

end

if __FILE__ == $0
>>>>>>> 0978c987354224fa810cb1da0b0c0341834ada13

  se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })

    binding.pry
end
