require 'pry'
require 'csv'
require_relative 'sales_engine'

class MerchantRepository
  attr_reader :name, :id
  attr_accessor :data, :merchants, :loaded_merchants

  def initialize(path)
    @merchants = load_data(path)
  end

  def load_data(path)
    @merchant_contents = CSV.open path, headers: true, header_converters: :symbol
    @loaded_merchants = @merchant_contents.to_a.map {|row| row.to_h}
    contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    @all_names = []
    @all_ids = []
    contents.each do |row|
      @all_ids << @id = row[:id]
      @all_names << @name = row[:name]
      @created_at = row[:created_at]
      @updated_at = row[:updated_at]
    end
  end

  def find_by_name(query_name)
    @all_names.find do |merchant_name|
      merchant_name.downcase == query_name.downcase
    end
  end

  def all
    @all_names
  end

  def find_by_id(id_query)
    find_id = @loaded_merchants.find do |merchant|
        id_query == merchant[:id]
      end
    if find_id.nil?
      nil
    else
      find_id[:name]
    end
  end

  def find_all_by_name(query_name)
    all_matching = []
    @all_names.find_all do |name|
      name.downcase.include?(query_name.downcase)
    end
    # all_matching
    #returns either []
    #or returns one or more matches which contain supplied name fragment
    #case insensitive
  end

  def self.from_csv(path)
    binding.pry #oesn't hit binding
    contents = CSV.open '../data/merchants.csv', headers: true, header_converters: :symbol
    contents.each do |row|
      binding.pry
      @id = row[:id]
      @name = row[:name]
      @created_at = row[:created_at]
      @updated_at = row[:updated_at]
      puts @name
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
