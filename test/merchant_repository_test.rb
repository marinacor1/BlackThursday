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
    #TODO check spec harness to see if merchant.name is right
  end

  def test_find_by_name_returns_nil_if_name_wrong
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("Marinas Shop")
    assert_equal nil, merchant
    #TODO check spec harness to see if merchant is right
  end

  def test_find_by_name_works_regardless_of_case
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("cjSdECOR")
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
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    assert_equal 'Shopin1901', se.merchants.all[0].name
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

  def test_merchant_repo_finds_all_matching_from_fragments_in_search
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('Mark')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["2MAKERSMARKET", "MarkThomasJewelry"], results
  end

  def test_merchant_repo_finds_all_matching_from_fragments_in_search_with_diff_fragment
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('Tim')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["ShopTimeCreations", "sparetimecrocheter", "funtimeworkshop"], results
  end

  def test_merchant_repo_finds_all_matching_from_fragments_regardless_of_case
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('TIM')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["ShopTimeCreations", "sparetimecrocheter", "funtimeworkshop"], results
  end

  def test_merchant_repo_finds_empty_array_if_wrong_fragment
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('xxxyx')
    assert_equal [], merchant
  end

  def test_merchant_references_items_as_array_of_item_objects
    skip
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      merchant = se.merchants.find_by_id(12334141)
      assert merchant.items.instance_of? Array
      assert merchant.items[0].instance_of? Item
    end

    def test_item_references_its_merchant_as_merchant_object
      skip 
      se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      item = se.items.find_by_id(263395237)
      assert item.merchant.instance_of? Merchant
    end

end
