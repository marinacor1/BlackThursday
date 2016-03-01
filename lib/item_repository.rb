require 'pry'
require 'csv'
require_relative 'item'

class ItemRepository
  attr_accessor :data

  def initialize(path)

  end

  def populate_items_with_data_from_csv(path)
  @data = []
  CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |row|

    i = Item.new
    i.id = row[:id]
    i.name = row[:name]
    i.description = row[:description]
    i.unit_price = row[:unit_price]
    i.merchant_id = row[:merchant_id]
    i.created_at = row[:created_at]
    i.updated_at = row[:updated_at]
    @data << i
  end
end



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
