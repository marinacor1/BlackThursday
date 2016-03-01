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

end
