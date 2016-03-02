require 'pry'
require 'csv'
require_relative 'sales_engine'
require_relative 'merchant'

class MerchantRepository
  attr_reader :name, :id, :count
  attr_accessor :data, :loaded_merchants

  def initialize(path)
    merchants  = populate_merchants_with_data_from_csv(path)
  end

  def populate_merchants_with_data_from_csv(path)
    @all_merchants = []
  CSV.foreach(path, { headers: true, header_converters: :symbol, converters: :all}) do |row|
      merchant = Merchant.new
      merchant.id = row[:id]
      merchant.name = row[:name]
      merchant.created_at = row[:created_at]
      merchant.updated_at = row[:updated_at]
      #merchant.items = @item_repo.find_by_id(merchant.id)
      @all_merchants << merchant
    end
  end

  def count
    @all_merchants.count
  end
  # def load_data(path)
  #   merchant_contents = CSV.open path, headers: true, header_converters: :symbol
  #   @loaded_merchants = merchant_contents.to_a.map {|row| row.to_h}
  #   contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
  #   @all_names = []
  #   @all_ids = []
  #   contents.each do |row|
  #     @all_ids << @id = row[:id]
  #     @all_names << @name = row[:name]
  #     created_at = row[:created_at]
  #     updated_at = row[:updated_at]
  #   end
  # end

  def find_by_name(query_name)
    @all_merchants.find do |merchant|
      merchant.name.downcase == query_name.downcase
    end
  end

  def all
    @all_merchants
  end

  def find_by_id(id_query)
    find_id = @all_merchants.find do |merchant|
      id_query == merchant.id
    end
  end

  def find_all_by_name(query_name)
    @all_merchants.find_all do |merchant|
      merchant.name.downcase.include?(query_name.downcase)
    end
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
