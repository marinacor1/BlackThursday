require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  def test_it_instantiates_a_merchant_repo
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    assert mr.instance_of? MerchantRepository
    assert mr.all[1].instance_of? Merchant
    assert_equal 3, mr.count
  end

  def test_merchants_are_accessed_and_found_in_find_by_name
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)
    merchant = mr.find_by_name("Seller")

    assert merchant.instance_of? Merchant
    assert_equal "Seller", merchant.name
  end

  def test_find_by_name_returns_nil_if_name_wrong
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_by_name("Marinas Shop")
    assert_equal nil, merchant
  end

  def test_find_by_name_works_regardless_of_case
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_by_name("sToRe")
    assert_equal "Store", merchant.name
  end

  def test_find_by_id_returns_correct_merchant_with_id
    se = SalesEngine.from_csv({
    :items     => "./data/subsets/items_small.csv",
    :merchants => "./data/subsets/merchants_small.csv"
    })

    merchant = se.merchants.find_by_id(24356)
    assert_equal "CandieandFood", merchant.name
    assert_equal 24356, merchant.id
    assert_equal Merchant, merchant.class
  end

  def test_find_by_id_returns_nil_for_wrong_id
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    merchant = se.merchants.find_by_id(10)
    assert_equal nil, merchant

  end


  def test_find_by_id_returns_nil_for_wrong_character_id
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_by_id('&kw')
    assert_equal nil, merchant
  end

  def test_merchants_all_creates_array_of_all_instances_of_merchant
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    assert mr.all.instance_of? Array
    assert_equal 'Merchant', mr.all[0].name
    assert_equal 3, mr.all.count
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

    def test_merchant_repo_instantiates_without_sales_engine
      mr = MerchantRepository.new
      assert_equal MerchantRepository, mr.class
    end

end
