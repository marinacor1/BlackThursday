require 'pry'
require 'bigdecimal'
require_relative 'merchant_repository'
require_relative 'item'
class SalesAnalyst
  attr_reader :average_items

  def initialize(se_data)
  @merchants = se_data.merchants
  @items = se_data.items
  end

  def average_items_per_merchant
    @average_items = BigDecimal.new((@items.count.to_f/ @merchants.count), 3).to_f
  end

  def average_items_per_merchant_standard_deviation
    total = 0
    @merchants.all.map do |merchant|
      dev_sq = (merchant.item_count - (@items.count.to_f/ @merchants.count))**2
      total += dev_sq
    end
    std_dev = Math.sqrt(total/(@merchants.count-1))
    @std_dev = BigDecimal.new(std_dev, 3).to_f
  end

  def merchants_with_high_item_count
    #returns an array of merchants who are more than one std dev
    #above the average number of products offered
  end

  def average_item_price_for_merchant(id_num)
    merchant = @merchants.all.find {|merchant| id_num == merchant.id}
    merchant_prices = merchant.items.map {|item| item.unit_price}
    avg = merchant_prices.inject(:+)/merchant_prices.count
    BigDecimal.new(avg, 4)
  end

  def average_average_price_per_merchant
    all_ids = find_all_merchant_ids
    all_averages = find_all_average_prices(all_ids)
    total_averages = all_averages.inject(:+)
    BigDecimal.new(total_averages/@merchants.count, 5)
  end

  def find_all_average_prices(all_ids)
    all_averages = all_ids.map do |id|
      average_item_price_for_merchant(id).to_f
    end
  end

  def find_all_merchant_ids
    all_ids = []
    @merchants.all.each do |merchant|
      merchant.items.each do |item|
        all_ids << item.merchant_id
      end
    end
    all_ids.uniq!
  end

  def golden_items
    #returns an array with all items that are two standard-devs above avg item price
  end
end
