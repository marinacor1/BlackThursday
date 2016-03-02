require 'minitest/autorun'
require 'minitest/pride'
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
    #pass in small subset
    sa = SalesAnalyst.new(se)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_sales_analyst_returns_avg_item_std_deviation
    skip
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
    skip
    sa = SalesAnalyst.new(se)
    big_decimal_num = 6
    assert_equal big_decimal_num, sa.average_item_price_for_merchant(12334105)
    assert_equal BigDecimal, big_decimal_num.class
  end

  def test_sa_can_find_average_price_across_all_merchants
    skip
    sa = SalesAnalyst.new(se)
    big_decimal_num = 5
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
