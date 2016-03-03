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
    merchant = mr.find_by_name("CJsDecor")
    assert_equal "CJsDecor", merchant.name
  end

end
