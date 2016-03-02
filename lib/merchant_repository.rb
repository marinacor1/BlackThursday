require 'pry'
require 'csv'
require_relative 'sales_engine'
require_relative 'merchant'
require_relative 'item_repository'

class MerchantRepository
  attr_reader :all

  def initialize(path)
    @all_merchants = []
    populate_merchant_repo_with_data_from_csv(path)
  end

  def populate_merchant_repo_with_data_from_csv(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      merchant = Merchant.new(data_row)
      # merchant.items = []
      # merchant.items << @all_items.find_by_id(merchant.id)
      @all_merchants << merchant
    end
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

if __FILE__ == $0
  se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    binding.pry

  end
