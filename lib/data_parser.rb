module DataParser

  def initialize
    if data[repos[repository]].include?('csv')
      repository.from_csv(data[repos[repository]])
    else
      repository.from_array(data[repos[repository]])
    end
  end

  def from_csv(path)
    CSV.foreach(path, { headers: true, header_converters: :symbol}) do |data_row|
      item = Item.new(data_row)
      @all_items << item
    end
  end

  def from_array(array)
    array.each do |attributes|
      item = Item.new(attributes)
      @all_items << item
    end
  end

end
