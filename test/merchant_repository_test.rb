require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant1, :merchant2, :merchant3, :mr, :merchants

  def setup
    merchant1 = Merchnat.new({id: 1, item_id: 10, invoice_id: 20, quantity: 2, unit_price: 13635, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    merchant2 = Merchnat.new({id: 2, item_id: 11, invoice_id: 20, quantity: 9, unit_price: 2196, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'})
    merchant3 = Merchnat.new({id: 3, item_id: 12, invoice_id: 21, quantity: 1, unit_price: 23324, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    merchant4 = Merchnat.new({id: 4, item_id: 12, invoice_id: 22, quantity: 1, unit_price: 79140, created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC'})

    @merchants = [merchant1, merchant2, merchant3, merchant4]

    @mr = MerchnatRepository.new(@merchants)
  end

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

  def test_find_by_name_returns_nil_if_name_wrong
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("Marinas Shop")
    assert_equal nil, merchant
  end

  def test_find_by_name_works_regardless_of_case
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("cjSdECOR")
    assert_equal "CJsDecor", merchant.name
  end

  def test_find_by_id_returns_correct_merchant_with_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/subsets/merchants_small.csv"
    })
    merchant = se.merchants.find_by_id(12334112)
    assert_equal "Candisart", merchant.name
    assert_equal 12334112, merchant.id
    assert_equal Merchant, merchant.class
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
    merchant = se.merchants.all
    assert_equal 'Shopin1901', merchant[0].name
    assert_equal 475, se.merchants.all.count
    assert_equal "Shopin1901", merchant.first.name
    assert_equal 'CJsDecor', merchant.last.name
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
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
      merchant = se.merchants.find_by_id(12334141)
      assert merchant.items.instance_of? Array
      assert merchant.items[0].instance_of? Item
    end

    def test_item_references_its_merchant_as_merchant_object
      se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
        item = se.items.find_by_id(263395237)
      assert item.merchant.instance_of? Merchant
    end

    def test_merchant_repo_insantiates_without_sales_enging
      mr = MerchantRepository.new(:merchants => 'Socks4All')
      assert_equal MerchantRepository, mr.class
    end

end
