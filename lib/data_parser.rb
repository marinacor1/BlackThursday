require 'csv'
require 'pry'

module DataParser

def load_data(data, destination, object)

  if data.include?('.csv')
    load_from_csv(data, destination, object)
  else
    load_from_array(data, destination, object)
  end

end

def load_from_csv(path, destination, object)
  CSV.foreach(path, { headers: true, header_converters: :symbol} ) do |data_row|
    new_object = object.new(data_row)
    destination.all << new_object
  end
end

def from_array(data, destination, object)
  data.each do |attributes|
    new_object = object.new(attributes)
    destination << new_object
  end
end

end
