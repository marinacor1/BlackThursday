require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_instantiates_from_csv
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.instance_of? SalesEngine
  end

  def test_sales_engine_carries_item_child_instance_for_item_repo
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.items.instance_of? ItemRepository
  end

  def test_sales_engine_carries_merchant_child_instance_for_merchant_repo
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    assert se.merchants.instance_of? MerchantRepository
  end

  def test_it_loads_items_and_merchants_from_csv
  hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
  se = SalesEngine.from_csv(hash)
    assert_equal 475 , se.merchants.count
    assert_equal 1367, se.items.count
  end

  def test_sales_engine_assigns_items_to_their_merchants
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })
  binding.pry
  merchant = se.merchants.find_by_id(10)
  merchant.items
  item = se.items.find_by_id(20)
  item.merchant
# => <merchant>
  end

end
