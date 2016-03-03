require 'pry'
require 'bigdecimal'
require_relative 'merchant_repository'
require_relative 'item'
class SalesAnalyst
attr_reader :average_items, :std_dev, :high_items, :avg_item_price, :item_price_stdev
  def initialize(se_data)
  @merchants = se_data.merchants
  @items = se_data.items
  end

  def average_items_per_merchant
    #this might not work with larger numbers
    @average_items = BigDecimal.new((@items.count.to_f/ @merchants.count), 3).to_f
  end

  def average_items_per_merchant_standard_deviation
    total = 0
    @merchants.all.each do |merchant|
      dev_sq = (merchant.item_count - (@items.count.to_f/ @merchants.count))**2
      total += dev_sq
    end
    std_dev = Math.sqrt(total/(@merchants.count-1))
    @std_dev = BigDecimal.new(std_dev, 3).to_f
  end

  def merchants_with_high_item_count
    #returns an array of merchants who are more than one std dev
    #above the average number of products offered
    @high_items = @merchants.all.map do |merchant|
        merchant if merchant.item_count > (@average_items+@std_dev)
    end.compact

  end

  def average_item_price_for_merchant(id_num)
    #returns the average price of a merchant's items (by supplying merchant id)

  end

  def average_average_price_per_merchant
    #sum of all average prices for merchants/ #total number of merchants
  end

  def golden_items
    #returns an array with all items that are two standard-devs above avg item price
    sum_item_prices = 0
    @items.all.map do |item|
      sum_item_prices += item.unit_price
    end
    @avg_item_price = sum_item_prices / @items.count


    total = 0
    @items.all.each do |item|
      dev_sq = (item.unit_price - (avg_item_price))**2
      total += dev_sq
    end
    std_dev = Math.sqrt(total/(@items.count-1))
    @item_price_stdev = std_dev

    result = @items.all.select do |item|
      item if item.unit_price > (@avg_item_price+(2*@item_price_stdev))
    end

  end
end

if __FILE__ == $0
  hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
  se = SalesEngine.from_csv(hash)
  sa = SalesAnalyst.new(se)
  sa.golden_items
end
