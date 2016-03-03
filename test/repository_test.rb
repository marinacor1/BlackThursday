require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require 'pry'

class RepositoryTest < Minitest::Test

  def test_repository_can_find_with_name
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_with_name(mr.all, "CJsDecor")
    assert_equal "CJsDecor", merchant.name
  end

  def test_repository_can_return_nil_if_wrong_query
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("Marinas Shop")
    assert_equal nil, merchant
  end



end
