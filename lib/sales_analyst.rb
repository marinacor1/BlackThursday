require 'pry'
require 'bigdecimal'
require 'time'
require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :std_dev, :high_items, :avg_item_price, :item_price_stdev, :item_count_stdev, :avg_items, :avg_invoices, :invoice_count_stdev, :invoices, :transactions

  def initialize(se_data)
    @merchants = se_data.merchants.all
    @items = se_data.items.all
    @invoices = se_data.invoices.all if se_data.invoices != nil
    @transactions = se_data.transactions.all if se_data.transactions != nil
    @invoice_items = se_data.invoice_items.all if se_data.invoice_items != nil
    @customers = se_data.customers.all if se_data.customers != nil
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
    all_squared_deviations = find_squared_deviations
    item_num_stdev = Math.sqrt(all_squared_deviations.inject(0, :+)/(all_squared_deviations.count-1))
    result = sprintf('%.2f', item_num_stdev).to_f
  end

  def find_squared_deviations
    @merchants.map do |merchant|
      dev_sq = (merchant.item_count - (@avg_items))**2
    end
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
      avg_price = (total_item_prices.to_f/merchant.item_count)
      merchant.avg_item_price = sprintf('%.2f', avg_price).to_f
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
  end

  def bottom_merchants_by_invoice_count
    low_invoice = @merchants.select do |merchant|
      merchant if merchant.invoice_count < (@avg_invoices-(2*@invoice_count_stdev))
    end
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

  # def total_revenue_by_date(date)
  #   date = date.strftime('%m-%e-%y')
  #   correct_date = @invoice_items.select do |item|
  #     item.updated_at.strftime('%m-%e-%y') == date
  #   end
  #   revenue = correct_date.inject(0) do |total, sale|
  #     total = total + sale.unit_price
  #   end
  #   revenue.to_f
  #   #TODO: is this a float or big decimal?
  # end

  def top_revenue_earners(num = 20)
    x = merchants_ranked_by_revenue.first(num)
  end

  def merchants_ranked_by_revenue
    sorted_merchants = @merchants.sort_by do |merchant|
      if merchant.revenue.nil?
        merchant.revenue = 0.0
      else
        merchant.revenue
      end
    end.reverse
    sorted_merchants
  end

  def find_merchant_by_item_id(merch, top_earner_ids)
    merch.items.find_all do |item|
      item.id == top_earner_ids[@index]
    end
  end

  def merchants_with_pending_invoices
    @merchants.select do |merchant|
       merchant.invoices.any? do |invoice|
         invoice.is_pending?
       end
    end
   end

  def merchants_with_only_one_item
    singular_shops = @merchants.select do |content|
      content.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    @merchants.each do |merchant| #there's only 3 merchants
      item_thing = []
      merchant.items.each do |item|
        #@created_at is a time, because of item class
        if item.created_at.strftime("%B") == month
          # item.created_at.month == Time.parse(month).month
          item_thing << item
        end
      end
    end
    #argument out of range error comes up
    monthly_merchants = item_thing.map do |item|
      item.merchant
    end
    monthly_merchants
    #returns array with merchants that only sell one item by the month they registered
    #use merchant.created_at
  end

  def revenue_by_merchant(query_id)
    invoice_ids = find_invoices_by_merchant_id(query_id)
    good_sales = find_all_successful_sales(invoice_ids)
    total_sales = find_total_for_good_sales(good_sales)
    totals = total_sales.inject(:+)
  end

  def find_invoices_by_merchant_id(query_id)
    invoice_ids = []
    @invoices.each do |invoice|
      if invoice.merchant_id == query_id
        invoice_ids << invoice.id
      end
    end
    invoice_ids
  end

  def find_all_successful_sales(invoice_ids)
    good_sales = []
    @transactions.each do |sale|
      if invoice_ids.include?(sale.invoice_id) && sale.result == 'success'
        good_sales << sale.invoice_id
      end
    end
    good_sales
  end

  def find_total_for_good_sales(good_sales)
    total_sales = []
    good_sales.each do |sale|
      @invoice_items.each do |item|
        if item.invoice_id == sale
          total_sales << (item.quantity * item.unit_price)
        end
      end
    end
    total_sales
  end

  def most_sold_item_for_merchant(query_id)
    correct_invoices = @invoices.select do |invoice|
      invoice.merchant.id == query_id
    end
    invoice_ids = correct_invoices.map do |inv|
      inv.id
    end
    correct_items = @invoice_items.select do |item|
      invoice_ids.include?(item.invoice_id)
    end
    correct_revenues = correct_items.sort_by do |item|
      item.quantity
    end.reverse
    top = @items.find do |item|
      item.id == correct_revenues[0].item_id
    end
  end


  def find_all_merchant_items(item_ids)
    @invoice_items.select do |sold_item|
      item_ids.include?(sold_item.item_id)
    end
  end

  def sort_merchant_items(merchant_sold_items)
    merchant_sold_items.sort_by do |item|
      item.quantity
    end.reverse
  end

  def top_item_tie_or_not(sorted_items)
    @items.select do |i|
      if sorted_items[0].quantity != sorted_items[1].quantity
        i.id == sorted_items[0].item_id
      else
        i.id == sorted_items[0].item_id || i.id == sorted_items[1].item_id
      end
    end
  end

  def best_item_for_merchant(query_id)
    merchant = @merchants.find { |merchant| merchant.id == query_id}
    item_ids = merchant_items = merchant.items.map { |thing| thing.id }
    merchant_sold_items = find_all_merchant_items(item_ids)
    sorted_items = sort_by_revenue(merchant_sold_items)
    top = top_item_tie_or_not(sorted_items)
    top[0]
  end

  def sort_by_revenue(merchant_sold_items)
    merchant_sold_items.sort_by do |item|
      (item.quantity * item.unit_price)
    end.reverse
  end

  def total_revenue_by_date(date)
    Time.parse(date) if !date.instance_of? Time
    invoice_array = find_all_successful_invoices_for_given_date(date)
    day_revenue = find_total_revenue_of_invoices_for_day(invoice_array)
  end

  def find_all_successful_invoices_for_given_date(date)
    @invoices.select do |invoice|
      invoice if invoice.created_at == (date) && invoice.paid
    end
  end

  def find_total_revenue_of_invoices_for_day(array)
    array.map do |invoice|
      invoice.total
    end.inject(0, :+)
  end

end

if __FILE__ == $0

  se = SalesEngine.from_csv( {:items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv",
    :invoice_items => "./data/invoice_items.csv" } )
    sa = SalesAnalyst.new(se)

binding.pry

  end
