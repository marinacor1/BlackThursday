require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_instantiates_a_merchant_repo
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    assert mr.instance_of? MerchantRepository
  end

  def test_merchants_are_accessed_and_found_in_find_by_name
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    assert_equal "CJsDecor", merchant.name
  end

  def test_find_by_id_returns_nil_for_wrong_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    merchant = se.merchants.find_by_id(10)
    assert_equal nil, merchant
  end

  def test_find_by_id_returns_nil_for_wrong_character_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    merchant = se.merchants.find_by_id('&kw')
    assert_equal nil, merchant
  end

  def test_merchants_all_works
    hash = {:id => 1, :name => 'yankee candle', :created_at => 1, :update_at => 1}
    merchant_repo = MerchantRepository.new(hash)
    assert_equal 'yankee candle', merchant_repo.all.name

  end

  def test_merchants_all_works_with_first
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.all
    assert_equal "Shopin1901", merchant.first.name
  end

  def test_merchants_all_works_with_last
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.all
    assert_equal 'CJsDecor', merchant.last.name
  end

  def test_merchant_find_id_works
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_id(12334105)
    assert_equal "Shopin1901", merchant.name
  end

  def test_merchant_find_id_returns_nil_for_wrong_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_id('12335')
    assert_equal nil, merchant
  end

  def test_merchant_repo_finds_all_fragments_in_search
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('Mark')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["2MAKERSMARKET", "MarkThomasJewelry"], results
  end

  def test_merchant_repo_finds_empty_array_if_wrong_fragment
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('xxxyx')
    assert_equal [], merchant
  end



end
