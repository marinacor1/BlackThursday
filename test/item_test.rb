require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/item'

class ItemTest < Minitest::Test

def test_it_instantiates_an_item_object
  item = Item.new({id: 521, name: "Fluffernutter", description: "It's a thing!", unit_price: 2000, merchant_id: 45, created_at: "01/01/01", updated_at: "08/08/08"})
  assert item.instance_of? Item
  assert_equal "Fluffernutter", item.name
end

def test_it_instantiates_an_item_object_with_parameters_from_spec
    data = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now}
    item = Item.new(data)
    assert item.instance_of? Item
  end

def test_item_class_has_access_to_item_info
  data = {
    :name        => "Pencil",
    :id          => 1232,
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now}
  item = Item.new(data)
  assert_equal "Pencil", item.name
  assert_equal "You can use it to write things", item.description
  assert_equal 1232, item.id
end

end
