require 'pry'
require 'csv'
require_relative 'item'
require_relative 'repository'

class ItemRepository
  include Repository
  attr_accessor :all

  def initialize(path)
    @all_items = []
    populate_item_repo(path)
  end

  def populate_item_repo(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      i = Item.new(data_row)
      @all_items << i
    end
  end

  def count
    @all_items.count
  end

  def all
    @all_items
  end

  def find_by_name(query_name)
    find_with_name(@all_items, query_name)
  end

  def find_by_id(id_query)
    find_with_id(@all_items, id_query)
  end

  def find_all_by_merchant_id(query_merch_id)
    @all_items.select do |item|
      item.merchant_id == query_merch_id
    end
  end

  def find_all_with_description(query_description)
    @all_items.select do |item|
      item.description.downcase.include?(query_description.downcase)
    end
  end

  def find_all_by_price(query_price)
    @all_items.select do |item|
      (item.unit_price) == query_price
      #this price needs to be converted to dollars
    end
  end

  def find_all_by_price_in_range(query_range)
    @all_items.select do |item|
      query_range.include?(item.unit_price) ? item : nil
      #this price needs to be converted to dollars
    end
  end


end




if __FILE__ == $0

  se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })

  ir   = se.items
  item = ir.find_by_name("Item Repellat Dolorum")
  binding.pry
end
