require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant1, :merchant2, :merchant3, :mr, :merchants

  def setup
    merchant1 = Merchant.new({id: 1, name: 'Furry socks', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    merchant2 = Merchant.new({id: 2, name: 'Cheetah print undies', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })
    merchant3 = Merchant.new({id: 3, name: 'Jalapeno deodorant', created_at: '2012-03-27 14:54:09 UTC', updated_at: '2012-03-27 14:54:09 UTC' })

    @merchants = [merchant1, merchant2, merchant3, merchant4]

    @mr = MerchantRepository.new(@merchants)
  end

  def test_it_instantiates_a_merchant_repo
    assert mr.instance_of? MerchantRepository
  end

  def test_merchants_are_accessed_and_found_in_find_by_name
    merchant = mr.find_by_name("CJsDecor")
    assert_equal "CJsDecor", merchant.name
  end

  def test_find_by_name_returns_nil_if_name_wrong
    merchant = mr.find_by_name("Marinas Shop")
    assert_equal nil, merchant
  end

  def test_find_by_name_works_regardless_of_case
    merchant = mr.find_by_name("cjSdECOR")
    assert_equal "CJsDecor", merchant.name
  end

  def test_find_by_id_returns_correct_merchant_with_id
    merchant = mr.find_by_id(12334112)
    assert_equal "Candisart", merchant.name
    assert_equal 12334112, merchant.id
    assert_equal Merchant, merchant.class
  end

  def test_find_by_id_returns_nil_for_wrong_id
    merchant = mr.find_by_id(10)
    assert_equal nil, merchant

  end

  def test_find_by_id_returns_nil_for_wrong_character_id
    merchant = mr.find_by_id('&kw')
    assert_equal nil, merchant
  end

  def test_merchants_all_works
    merchant = mr.all
    assert_equal 'Shopin1901', merchant[0].name
    assert_equal 475, se.merchants.all.count
    assert_equal "Shopin1901", merchant.first.name
    assert_equal 'CJsDecor', merchant.last.name
  end

  def test_merchant_find_id_returns_nil_for_wrong_id
    merchant = mr.find_by_id('12335')
    assert_equal nil, merchant
  end

  def test_merchant_repo_finds_all_matching_from_fragments_in_search
    merchant = mr.find_all_by_name('Mark')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["2MAKERSMARKET", "MarkThomasJewelry"], results
  end

  def test_merchant_repo_finds_all_matching_from_fragments_in_search_with_diff_fragment
    merchant = mr.find_all_by_name('Tim')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["ShopTimeCreations", "sparetimecrocheter", "funtimeworkshop"], results
  end

  def test_merchant_repo_finds_all_matching_from_fragments_regardless_of_case
    merchant = mr.find_all_by_name('TIM')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["ShopTimeCreations", "sparetimecrocheter", "funtimeworkshop"], results
  end

  def test_merchant_repo_finds_empty_array_if_wrong_fragment
    merchant = mr.find_all_by_name('xxxyx')
    assert_equal [], merchant
  end

  def test_merchant_references_items_as_array_of_item_objects
      merchant = se.merchants.find_by_id(12334141)
      assert merchant.items.instance_of? Array
      assert merchant.items[0].instance_of? Item
    end

    def test_item_references_its_merchant_as_merchant_object
        item = mr.find_by_id(263395237)
      assert item.merchant.instance_of? Merchant
    end

end
