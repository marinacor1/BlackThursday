require 'pry'
require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_accessor :items, :merchants, :merchant

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    merchant_items_assigned_by_id
  end

  def merchant_items_assigned_by_id
     @merchants.all.map do |merchant|
      merchant.items = @items.find_all_by_merchant_id(merchant.id)
      merchant.item_count = merchant.items.count
    end
    @merchant
  end

  def self.from_csv(data)
    all_instances = self.new(data)
  end

  def self.items
    @items
  end

  def self.merchants
    @merchants 
  end


end
