require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_sales_analyst_instantiates
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    sa.instance_of? SalesAnalyst
  end

  def test_sales_analyst_tells_how_avg_products_merchants_sell
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    answer = 2.88
    assert_equal answer, sa.average_items_per_merchant
    assert_equal Float, answer.class
  end

  def test_sales_analyst_tells_how_many_products_merchants_sell_with_subset
    skip
    #change subset
    hash = {:items => "./data/subsets/items_small.csv", :merchants => "./data/subsets/merchants_small.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    answer = 2.88
    assert_equal answer, sa.average_items_per_merchant
    assert_equal Float, answer.class
  end

  def test_sales_analyst_returns_avg_item_std_deviation
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    answer = 3.26
    assert_equal answer, sa.average_items_per_merchant_standard_deviation
    assert_equal Float, answer.class
  end

  def test_sales_analyst_returns_avg_item_std_deviation_from_subset
    skip
    #test using subset
    sa = SalesAnalyst.new(se)
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_sales_analyst_returns_merchants_with_high_item_counts
    skip
    sa = SalesAnalyst.new(se)
    merchant_array = ['merchant', 'merchant']
    assert_equal merchant_array, sa.merchants_with_high_item_count
    assert_equal Merchant, merchant_array.class
  end

  def test_sa_finds_avg_price_of_merchants_items_by_id_number
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    answer = 16.66
    big_decimal_num = BigDecimal.new(answer, 4)
    assert_equal big_decimal_num, sa.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, big_decimal_num.class
  end
meta a: true
  def test_sa_can_find_average_price_across_all_merchants
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    sa = SalesAnalyst.new(se)
    answer = 350.3
    big_decimal_num = BigDecimal.new(answer, 5)
    assert_equal big_decimal_num, sa.average_average_price_per_merchant
    assert_equal BigDecimal, big_decimal_num.class
  end

  def test_sa_finds_all_golden_items
    skip
    sa = SalesAnalyst.new(se)
    # golden_array = [<item>, <item>, <item>]
    golden_array = []
    assert_equal golden_array, sa.golden_items
    assert_equal Item, golden_array.class
  end


end
