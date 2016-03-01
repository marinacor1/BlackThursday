require 'pry'
require 'csv'
require_relative 'sales_engine'

class MerchantRepository
  attr_accessor :data, :merchants

  def initialize(path)
    @merchants
  end

  def self.from_csv(path)
    contents = CSV.open '../data/merchants.csv', headers: true, header_converters: :symbol
    contents.each do |row|
      binding.pry
      @name = row[:name]
      @id = row[:id]
      @description = row[:description]
      @unit_price = row[:unit_price]
      puts @name
  end

  def all
    #returns array of all known merchant instances
  end

  def find_by_id
    #returns nil if no merchant found with id
    #else returns instance of merchant with matching id
  end

  def find_by_name(query_name)
    if @name.downcase == query_name.downcase
      @name
    else
      nil
    end
    #returns nil if no name found (case insensitive)
    #returns instance of merchant if name matches (case insensitive)
  end

  def find_all_by_name(query_name)
    #returns either []
    #or returns one or more matches which contain supplied name fragment
    #case insensitive
  end


end


end
#define initalization methods that takes
#takes into account design
#we are giving it this string
#parsing could happen here
#you could pass it in already parsed data (item objects)


#Jan's suggestion:
#I would have a from_csv on merchants repository classes
#repository classes would handle their own data(parse the data)
#parse and organize data

#sales engine can do manipulation and business logic
