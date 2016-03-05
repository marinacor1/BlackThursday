require 'pry'
require 'bigdecimal'
require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :std_dev, :high_items, :avg_item_price, :item_price_stdev, :item_count_stdev, :avg_items

  def initialize(se_data)
    @merchants = se_data.merchants.all
    @items = se_data.items.all 
    @invoices = se_data.invoices.all
    begin_analysis
  end

  def begin_analysis
    @avg_items = average_items_per_merchant
    @item_count_stdev = average_items_per_merchant_standard_deviation
    merchants_know_their_average_item_price
    @avg_inv = average_invoices_per_merchant
    @inv_count_stdev = average_invoices_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    average_items = sprintf('%.2f', (@items.count.to_f/@merchants.count)).to_f
  end

  def average_items_per_merchant_standard_deviation
    all_squared_deviations = @merchants.all.map do |merchant|
      dev_sq = (merchant.item_count - (@avg_items))**2
    end
    item_num_stdev = Math.sqrt(all_squared_deviations.inject(0, :+)/(all_squared_deviations.count-1))
    result = sprintf('%.2f', item_num_stdev).to_f
  end

  def merchants_with_high_item_count
    high_items = @merchants.select do |merchant|
      merchant if merchant.item_count > (@avg_items+@item_count_stdev)
    end

  end

  def merchants_know_their_average_item_price
    @merchants.map do |merchant|
      total_item_prices = merchant.items.map do |item|
        item.unit_price
      end.inject(0, :+)
      merchant.avg_item_price = sprintf('%.2f', (total_item_prices.to_f/merchant.item_count)).to_f
      merchant
    end
  end

  def average_item_price_for_merchant(query_id)
    merchant = @merchants.find { |merchant| merchant.id == query_id}
    average_price = BigDecimal.new(merchant.avg_item_price, 5)
  end

  def average_average_price_per_merchant
    total_avg_prices = @merchants.inject(0){|sum, merchant| sum + merchant.avg_item_price}
    average_average = BigDecimal.new((total_avg_prices/@merchants.count), 4)
  end

  def golden_items
    average_price = average_item_price
    item_price_stdev = calculate_std_deviation_of_item_prices(average_price)
    find_items_priced_two_or_more_std_dev_above_average_item(item_price_stdev, average_price)
  end

  def find_items_priced_two_or_more_std_dev_above_average_item(item_price_stdev, avg_price)
    golden_items = @items.select do |item|
      item if item.unit_price > (avg_price+(2*item_price_stdev))
    end
  end

  def average_item_price
    all_item_prices  = @items.map do |item|
      item.unit_price
    end
    avg_item_price = all_item_prices.inject(0, :+) / all_item_prices.count
    @avg_item_price = sprintf('%.2f', avg_item_price).to_f
  end

  def calculate_std_deviation_of_item_prices(avg_item_price)
    all_squared_deviations = @items.map do |item|
      (item.unit_price - (avg_item_price))**2
    end
    item_price_stdev = Math.sqrt(all_squared_deviations.inject(0, :+)/(all_squared_deviations.count-1))
  end


  def average_invoices_per_merchant
    avg_inv = sprintf('%.2f', (@invoices.count.to_f/@merchants.count)).to_f
    #returns float like 8.5
  end

  def average_invoices_per_merchant_standard_deviation
    all_squared_deviations = @merchants.map do |merchant|
      dev_sq = (merchant.invoice_count - @avg_inv)**2
    end
    item_num_stdev = Math.sqrt(all_squared_deviations.inject(0, :+)/(all_squared_deviations.count-1))
    result = sprintf('%.2f', item_num_stdev).to_f
    #returns float like 1.2
  end

  def top_merchants_by_invoice_count
    high_invoice = @merchants.select do |merchant|
      merchant if merchant.invoice_count > (@avg_inv+(2*@inv_count_stdev))
    end
    #returns array of merchants that are more than two std dev above mean
  end

  def bottom_merchants_by_invoice_count
    low_invoice = @merchants.select do |merchant|
      merchant if merchant.invoice_count < (@avg_inv-(2*@inv_count_stdev))
    end
    #returns array with merchant that are more than two std dev below mean
  end

  def top_days_by_invoice_count
    day_of_hash = @invoices.group_by do |invoice|
      date = Date.parse(invoice.created_at)
      date.strftime("%A")
    end
    binding.pry
    #returns array with days that have invoices created more than one std dev above mean
  end

  def invoice_status(status_query)
    #returns float like 5.25 or 1.00 that is the percentage of invoices for a certain status
    #takes symbol as argument
  end
end

if __FILE__ == $0

  se = SalesEngine.from_csv( {:items => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"} )
  se.repositories_linked
  sa = SalesAnalyst.new(se)
  sa.begin_analysis

  binding.pry

end
