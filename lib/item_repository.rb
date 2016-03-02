require 'pry'
require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @all_items = []
    populate_item_repo_with_data_from_csv(path)
  end

  def populate_item_repo_with_data_from_csv(path)
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
    finder = @all_items.find do |item|
      item.name.downcase == query_name.downcase
    end
  end

  def find_by_id(query_id)
    finder = @all_items.find do |item|
      item.id == query_id
    end
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







#
# require 'pry'
# require 'csv'
# require_relative 'sales_engine'
#
# class MerchantRepository
#   attr_reader :name
#   attr_accessor :data, :merchants
#
#   def initialize(path)
#     @merchants = load_data(path)
#   end
#
#   def load_data(path)
#     @merchant_contents = CSV.open path, headers: true, header_converters: :symbol
#     loaded_merchants = @merchant_contents.to_a.map {|row| row.to_h}
#     contents = CSV.open './data/items.csv', headers: true, header_converters: :symbol
#     @all_names = []
#     contents.each do |row|
#       @id = row[:id]
#       @all_names << @name = row[:name]
#       @created_at = row[:created_at]
#       @updated_at = row[:updated_at]
#   end
#
#   end
#
#   def find_by_name(query_name)
#     binding.pry
#     @all_names.find do |merchant_name|
#       merchant_name.downcase == query_name.downcase
#     end
#   end
#
#   def all
#     #returns array of all known merchant instances
#   end
#
#   def find_by_id
#     #returns nil if no merchant found with id
#     #else returns instance of merchant with matching id
#   end
#
#
#   def find_all_by_name(query_name)
#     #returns either []
#     #or returns one or more matches which contain supplied name fragment
#     #case insensitive
#   end
#
#   def self.from_csv(path)
#     binding.pry #oesn't hit binding
#     contents = CSV.open '../data/merchants.csv', headers: true, header_converters: :symbol
#     contents.each do |row|
#       binding.pry
#       @id = row[:id]
#       @name = row[:name]
#       @created_at = row[:created_at]
#       @updated_at = row[:updated_at]
#       puts @name
#   end
# end
#
#
# end
# #define initalization methods that takes
# #takes into account design
# #we are giving it this string
# #parsing could happen here
# #you could pass it in already parsed data (item objects)
#
#
# #Jan's suggestion:
# #I would have a from_csv on merchants repository classes
# #repository classes would handle their own data(parse the data)
# #parse and organize data
#
# #sales engine can do manipulation and business logic
#
#
# # end
# #define initalization methods that takes
# #takes into account design
# #we are giving it this string
# #parsing could happen here
# #you could pass it in already parsed data (item objects)
#
#
# #Jan's suggestion:
# #I would have a from_csv on merchants repository classes
# #repository classes would handle their own data(parse the data)
# #parse and organize data
#
# #sales engine can do manipulation and business logic
