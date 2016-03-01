require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_instantiates_a_sales_engine
    se = SalesEngine.new
    assert_equal SalesEngine, se.class
  end

  def test_it_instantiates_with_item_and_merchant_repos
    se = SalesEngine.new
    assert_equal ItemRepository, se.items.class
    assert_equal MerchantRepository, se.merchants.class
  end

  def test_sales_engine_instantiates_from_csv
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
      se.instance_of? SalesEngine
  end

  def test_sales_engine_carries_item_child_instance
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.items.instance_of? ItemRepository
  end

  def test_sales_engine_carries_merchant_child_instance
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.merchants.instance_of? MerchantRepository
  end

  def test_it_loads_items_and_merchants_from_csv
    skip
    se = SalesEngine.new
    se.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    end
end
