require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_instantiates_from_csv
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
      se.instance_of? SalesEngine
  end

  def test_merchants_are_accessed_through_sales_engine
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    assert_equal "CJsDecor", merchant.name
    assert_equal "", merchant
  end

end
