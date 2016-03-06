require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def test_sales_analyst_instantiates
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    assert sa.instance_of? SalesAnalyst
  end

  def test_sales_analyst_calculates_avg_products_merchants_sell
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    answer = 2.88
    assert_equal answer, sa.average_items_per_merchant
    assert_equal Float, answer.class
  end

  def test_sales_analyst_tells_how_many_products_merchants_sell_with_subset
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    se.repositories_linked
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    answer = 2.88
    assert_equal answer, sa.average_items_per_merchant
    assert_equal Float, answer.class
  end

  def test_sales_analyst_returns_avg_item_std_deviation
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

      answer = 3.26
      calculated = sa.average_items_per_merchant_standard_deviation
    assert_equal answer, calculated
    assert_equal Float, calculated.class
  end

  def test_sales_analyst_returns_avg_item_std_deviation_from_subset
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_sales_analyst_returns_merchants_with_high_item_counts
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    high_items = sa.merchants_with_high_item_count
    example_count = high_items[0].item_count

    assert example_count > (sa.avg_items + sa.item_count_stdev)
    assert high_items.instance_of? Array
    assert_equal Merchant, high_items[0].class
    assert_equal 52, high_items.count
  end

  def test_sa_finds_avg_price_of_merchants_items_by_id_number
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    answer = 16.66
    big_decimal_num = BigDecimal.new(answer, 4)
    assert_equal big_decimal_num, sa.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, big_decimal_num.class
  end

  def test_sa_can_find_average_average_price_across_all_merchants
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    answer = 350.29
    avg_avg = sa.average_average_price_per_merchant

    assert_equal BigDecimal(answer, 5), avg_avg
    assert avg_avg.instance_of? BigDecimal
  end

  def test_sa_finds_all_golden_items
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)

    golden_array = sa.golden_items
    assert_equal 5, golden_array.count
    assert golden_array.instance_of? Array
  end

  def test_find_average_merchant_invoices_works
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_average_invoices_has_std_dev
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_sa_can_find_top_performing_merchants_through_invoice_count
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    threshhold = sa.avg_invoices + (sa.invoice_count_stdev*2)
    top_merchants = sa.top_merchants_by_invoice_count

    assert top_merchants.instance_of? Array
    assert_equal 12, top_merchants.count
    assert top_merchants[0].invoice_count > threshhold
  end

  def test_sa_can_find_lowest_performing_merchants_through_invoice_count
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    threshhold = sa.avg_invoices - (sa.invoice_count_stdev*2)
    bottom_merchants = sa.bottom_merchants_by_invoice_count

    assert bottom_merchants.instance_of? Array
    assert_equal 4, bottom_merchants.count
    assert bottom_merchants[0].invoice_count < threshhold
  end

  def test_sa_finds_top_sale_days
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    correct_days = ['Wednesday']
    top_days = sa.top_days_by_invoice_count

    assert_equal correct_days, top_days
    assert_equal 1, top_days.count
  end

  def test_gives_status_percentage
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.begin_analysis

    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end


end
