require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_instantiates_an_item_repo
    items = ItemRepository.new
    assert_equal ItemRepository, items.class
  end

  def test_item_repo_can_find_by_name
    skip
    items = ItemRepository
    assert_equal ItemRepository, items.class
  end


  def test_merchant_can_be_found_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    item = se.items.find_by_id(20)
    assert_equal " ", item.merchant
  end

  def test_item_repo_can_find_by_name
    skip
    se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
  })
    ir   = se.items
    item = ir.find_by_name("Item Repellat Dolorum")
    assert_equal "Item Repellat Dolorum", item.name
    assert item.instance_of?(Item)
  end




end
