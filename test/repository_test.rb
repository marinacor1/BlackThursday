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
    merchant = mr.find_with_name(mr.all, "Marinas Shop")
    assert_equal nil, merchant
  end

  def test_repository_finds_with_name_regardless_of_case
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_with_name(mr.all, "keckenBAUer")
    assert_equal "Keckenbauer", merchant.name
  end

  def test_repo_finds_with_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_with_id(mr.all, 12334135)
    assert_equal "GoldenRayPress", merchant.name
  end

  def test_repo_finds_with_id_returns_nil_for_wrong_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_with_id(mr.all, 1135)
    assert_equal nil , merchant
  end



end
