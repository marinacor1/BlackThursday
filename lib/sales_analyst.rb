require_relative 'merchant_repository'
require_relative 'item'
class SalesAnalyst

  def initialize(se_data)
  end

  def average_items_per_merchant
    #total_number_of_merchants/ #total_number_of_items
  end

  def average_items_per_merchant_standard_deviation

  end

  def merchants_with_high_item_count
    #returns an array of merchants who are more than one std dev
    #above the average number of products offered
  end

  def average_item_price_for_merchant(id_num)
    #returns the average price of a merchant's items (by supplying merchant id)
  end

  def average_average_price_per_merchant
    #sum of all average prices for merchants/ #total number of merchants
  end

  def golden_items
    #returns an array with all items that are two standard-devs above avg item price
end
