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

  def test_find_by_id_returns_nil_for_wrong_id
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_by_id(10)
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

  def test_merchant_find_id_returns_nil_for_wrong_id
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_by_id('12335')
    assert_equal nil, merchant
  end

  def test_merchant_repo_finds_all_matching_from_fragments_in_search
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]

    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_all_by_name('er')
    results = merchant.map {|merchant| merchant.name}

    assert_equal ["Merchant", "Seller"], results
  end

  def test_merchant_repo_finds_all_matching_from_fragments_in_search_with_diff_fragment
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_all_by_name('S')
    results = merchant.map {|merchant| merchant.name}

    assert_equal ["Store", "Seller"], results
  end

  def test_merchant_repo_finds_all_matching_from_fragments_regardless_of_case
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_all_by_name('s')
    results = merchant.map {|merchant| merchant.name}
    assert_equal ["Store", "Seller"], results
  end

  def test_merchant_repo_finds_empty_array_if_wrong_fragment
    data = [{:name => "Merchant", :id => 1}, {:name => "Store", :id => 2}, {:name => "Seller", :id => 3}]
    mr = MerchantRepository.new
    mr.from_array(data)

    merchant = mr.find_all_by_name('xxxyx')
    assert_equal [], merchant
  end

end
