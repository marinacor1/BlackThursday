require 'pry'
require 'csv'
require_relative 'item'
require_relative 'repository'

class ItemRepository
  def inspect
    true
  end
  
  include Repository
  attr_accessor :all, :item

  def initialize(path)
    @all_items = []
    populate_item_repo(path)
  end

  def populate_item_repo(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |data_row|
      @item = Item.new(data_row)
      @all_items << item
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
    find_all_by_num(@all_items, query_merch_id, :merchant_id)
  end

  def find_all_with_description(query_description)
    find_all_by_string(@all_items, query_description, :description)
  end

  def find_all_by_price(query_price)
    find_all_by_num(@all_items, query_price, :unit_price)
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
