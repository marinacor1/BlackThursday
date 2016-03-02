require 'pry'
require 'csv'
require_relative 'sales_engine'
require_relative 'merchant'
require_relative 'item_repository'

class MerchantRepository
  attr_accessor :all_merchants, :name

  def initialize(path)
    @all_merchants = []
    if path.include?'.csv'
      populate_merchant_repo_with_data_from_csv(path)
    else
      populate_merchant_repo_with_hash(path)
    end
  end

  def populate_merchant_repo_with_data_from_csv(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      merchant = Merchant.new(data_row)
      @all_merchants << merchant
    end
  end

  def merchants_and_items_linked(item_repository)
     @all_merchants.map do |merchant|
      merchant.items = item_repository.find_all_by_merchant_id(merchant.id)
      merchant.item_count = merchant.items.count
      merchant
    end
    item_repository.all.map do |item|
      item.merchant = self.find_by_id(item.merchant_id)
    end
  end


  def populate_merchant_repo_with_hash(path)
    merchant = Merchant.new(path)
    merchant.id = path[:id]
    merchant.name = path[:name]
    merchant.created_at = path[:created_at]
    merchant.updated_at = path[:updated_at]
    @all_merchants << merchant
  end

  def all
    @all_merchants
  end

  def count
    @all_merchants.count
  end

  def find_by_name(query_name)
    @all_merchants.find do |merchant|
      merchant.name.downcase == query_name.downcase
    end
  end

  def find_by_id(id_query)
    @all_merchants.find do |merchant|
      id_query == merchant.id
    end
  end

  def find_all_by_name(query_name)
    @all_merchants.select do |merchant|
       merchant.name.downcase.include?(query_name.downcase) ? merchant : nil
    end
  end

end
