require 'pry'
require 'csv'
require_relative 'sales_engine'
require_relative 'merchant'
require_relative 'item_repository'
require_relative 'repository'

class MerchantRepository

  def inspect
    "#<#{self.class}>"
  end

  include Repository

  attr_accessor :all, :name

  def initialize
    @all_merchants = []
  end

  def from_csv(path)
    if path.include? '.csv'
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      merchant = Merchant.new(data_row)
      @all_merchants << merchant
    end
    else
      populate_merchant_repo_with_hash(path)
    end
  end

  def from_array(array)
    array.each do |attributes|
      merchant = Merchant.new(attributes)
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
    find_with_name(@all_merchants, query_name)
  end

  def find_by_id(id_query)
    find_with_id(@all_merchants, id_query)
  end

  def find_all_by_name(query_name)
    find_all_by_string(@all_merchants, query_name, :name)
  end

end
