require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    # merchant_assignments_by_id
  end

  def merchant_assignments_by_id
    binding.pry
    @merchants = @merchants.all.map do |merchant|
      merchant.items = @items.find_by_merchant_id(merchant.id)
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
  binding.pry
end
