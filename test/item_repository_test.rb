require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_item_repo_class_instantiates_an_item_repo
    data = [{:name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(200, 4), :created_at  => Time.now, :updated_at  => Time.now },{:name => "Paper", :description => "You can write things on it", :unit_price  => BigDecimal.new(100, 4), :created_at  => Time.now, :updated_at  => Time.now },{:name => "Stapler", :description => "Red Swingline", :unit_price  => BigDecimal.new(700, 4), :created_at  => Time.now, :updated_at  => Time.now,}]

    ir = ItemRepository.new
    ir.from_array(data)

    assert_equal 3, ir.count
    assert ir.all[1].instance_of? Item
    assert ir.instance_of? ItemRepository
  end

  def test_item_can_be_found_in_repo_by_id
    data = [{:name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(200, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 390 },{:name => "Paper", :description => "You can write things on it", :unit_price  => BigDecimal.new(100, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 777 }]

    ir = ItemRepository.new
    ir.from_array(data)

    desired_item = ir.find_by_id(390)
    assert_equal desired_item.id, 390
    assert desired_item.instance_of? Item
  end

  def test_item_can_be_found_in_repo_by_name
    data = [{:name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(200, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 390 },{:name => "Paper", :description => "You can write things on it", :unit_price  => BigDecimal.new(100, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 777 }]

    ir = ItemRepository.new
    ir.from_array(data)

    desired_item = ir.find_by_name("Paper")
    assert_equal "Paper", desired_item.name
    assert desired_item.instance_of? Item
  end

  def test_id_search_and_name_search_return_nil_for_no_results
    data = [{:name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(200, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 390 },{:name => "Paper", :description => "You can write things on it", :unit_price  => BigDecimal.new(100, 4), :created_at  => Time.now, :updated_at  => Time.now, :id => 777 }]

    ir = ItemRepository.new
    ir.from_array(data)

    desired_item = ir.find_by_name("jklsjklasfdjlkafsdj")
    another_item = ir.find_by_id(11)
    assert_equal nil, desired_item
    assert_equal nil, another_item
  end


end
