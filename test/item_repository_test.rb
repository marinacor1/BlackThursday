require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_item_repo_class_instantiates_an_item_repo
    items = ItemRepository.new("./data/items.csv")
    assert items.instance_of? ItemRepository
  end

  def test_item_can_be_found_in_repo_by_id
    items = ItemRepository.new("./data/items.csv")
    desired_item = items.find_by_id(263412425)
    assert_equal desired_item.id, 263412425
    assert desired_item.instance_of? Item
  end

  def test_item_can_be_found_in_repo_by_name
    items = ItemRepository.new("./data/items.csv")
    desired_item = items.find_by_name("Course contre la montre")
    assert_equal desired_item.name, "Course contre la montre"
    assert desired_item.instance_of? Item
  end

  def test_id_search_and_name_search_return_nil_for_no_results
    items = ItemRepository.new("./data/items.csv")
    desired_item = items.find_by_name("jklsjklasfdjlkafsdj")
    another_item = items.find_by_id(11)
    assert_equal nil, desired_item
    assert_equal nil, another_item
  end


end
