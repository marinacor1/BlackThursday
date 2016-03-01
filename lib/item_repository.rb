require 'pry'
require 'csv'

class ItemRepository
  attr_accessor :data

  def initialize(hash)
    @items
  end

  def self.from_csv(path)
    self.new.data = CSV.open '../data/items.csv', headers: true, header_converters: :symbol
    # contents.each do |row|
    #   binding.pry
    #   name = row[:name]
    #   id = row[:id]
    #   description = row[:description]
    #   unit_price = row[:unit_price]
    #   puts name
  end

end


# end
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
