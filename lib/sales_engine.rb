require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants, :loaded_items, :loaded_merchants

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
  end

  def self.from_csv(data)
    all_instances = self.new(data)
  end


end
