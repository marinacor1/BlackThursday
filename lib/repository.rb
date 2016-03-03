module Repository

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

  def find_all_number(all_content.identifier, query_number)
    all_content.select do |content|
      content.identifier == query_number
    end
       #returns empty array if no match
       #returns one or more matches with matching id
  end

  def find_all_by_status(id_num)
   #returns empty array if no match
   #returns one or more matches with matching id
  end


end
