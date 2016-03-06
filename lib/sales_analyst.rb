require 'pry'
require 'bigdecimal'
require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :std_dev, :high_items, :avg_item_price, :item_price_stdev, :item_count_stdev, :avg_items, :avg_invoices, :invoice_count_stdev

  def initialize(se_data)

    @merchants = se_data.merchants.all
    @items = se_data.items.all
    @invoices = se_data.invoices.all if se_data.invoices != nil
    begin_analysis
  end

  def begin_analysis
    @avg_items = average_items_per_merchant
    @item_count_stdev = average_items_per_merchant_standard_deviation
    merchants_know_their_average_item_price
    @avg_invoices = average_invoices_per_merchant if @invoices != nil
    @invoice_count_stdev = average_invoices_per_merchant_standard_deviation if @invoices != nil
  end

  def average_items_per_merchant
    average_items = sprintf('%.2f', (@items.count.to_f/@merchants.count)).to_f
  end

  def average_items_per_merchant_standard_deviation
    all_squared_deviations = @merchants.map do |merchant|
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
    average_average = BigDecimal.new((total_avg_prices/@merchants.count), 5)
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

      dev_sq = (merchant.invoice_count - @avg_invoices)**2
    end
    item_num_stdev = Math.sqrt(all_squared_deviations.inject(0, :+)/(all_squared_deviations.count-1))
    result = sprintf('%.2f', item_num_stdev).to_f
  end

  def top_merchants_by_invoice_count
    high_invoice = @merchants.select do |merchant|
      merchant if merchant.invoice_count > (@avg_invoices+(2*@invoice_count_stdev))
    end
    #returns array of merchants that are more than two std dev above mean
  end

  def bottom_merchants_by_invoice_count
    low_invoice = @merchants.select do |merchant|
      merchant if merchant.invoice_count < (@avg_invoices-(2*@invoice_count_stdev))
    end
    #returns array with merchant that are more than two std dev below mean
  end

  def top_days_by_invoice_count
   day_counts = find_sales_count_per_day
   average_value = calculate_average_value(day_counts.values)
   std_deviation = calculate_standard_deviation(day_counts.values, average_value)
   metric = std_deviation + average_value
   find_days_over_one_std_dev_higher_than_average(day_counts, metric)
 end

 def find_sales_count_per_day
   day_of_hash = @invoices.reduce(Hash.new(0)) do |hash, invoice|
     date = invoice.created_at
     date = date.strftime("%A")
     hash[date] += 1
     hash
   end
 end

 def calculate_average_value(array)
    number_of_items = array.count
    sum_of_items = array.inject(0, :+)
    average = sum_of_items/number_of_items
  end

  def calculate_standard_deviation(array, average_value)
    all_squared_deviations = array.map do |value|
      dev_sq = (value - (average_value))**2
    end
    item_num_stdev = Math.sqrt(all_squared_deviations.inject(0, :+)/(all_squared_deviations.count-1))
    result = sprintf('%.2f', item_num_stdev).to_f
  end

  def find_days_over_one_std_dev_higher_than_average(hash, metric)
    high_sales_days = hash.select do |day|
      hash[day] > metric
    end
    high_sales_days.keys
  end

  def invoice_status(status_query)
    invoice_status_count = @invoices.count do |invoice|
      invoice.status == status_query
    end

    invoice_count = @invoices.count
    percentage_status = (invoice_status_count.to_f/invoice_count)
    percentage = sprintf('%.2f', (percentage_status*100)).to_f
  end


  def total_revenue_by_date(date)
    #gives total revenue for a date
  end

  def top_revenue_earners(num = 20)
    #returns array for top merchant revenue earners
    #calculate revenue using invoice_item.unit_price
  end

  def merchants_with_pending_invoices
    #returns array of all merchants with pending invoices
    #pending - if no transactions are successful
  end

  def merchants_with_only_one_item
    #returns array of merchants with only one item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    #returns array with merchants that only sell one item by the month they registered
    #use merchant.created_at
  end

  def revenue_by_merchant(merchant_id)
    #returns Big Decimal answer of total revenue for merchant
  end

  def most_sold_item_for_merchant(merchant_id)
    #returns highest item in terms of quantity sold
    #if tie it returns tie of items 
  end

  def best_item_for_merchant(merchant_id)
    #returns highest item by revenue generated
  end




end

if __FILE__ == $0

  se = SalesEngine.from_csv( {:items => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"} )
  sa = SalesAnalyst.new(se)

  binding.pry

end
