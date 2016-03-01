require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_merchants_are_accessed
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    # merchant = mr.find_by_name("CJsDecor")
    merchant2 = mr.find_by_name("Free standing Woden letters")
    # assert_equal "CJsDecor", merchant
    assert_equal "Free standing Woden letters", merchant2
  end

end
