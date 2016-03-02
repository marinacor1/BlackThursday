require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/item'

class ItemTest < Minitest::Test

def test_it_instantiates_an_item_object
  item = Item.new({id: 521, name: "Fluffernutter", description: "It's a thing!", unit_price: 2000, merchant_id: 45, created_at: "01/01/01", updated_at: "08/08/08"})
  data = {
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
  }
  item = Item.new(data)
  assert item.instance_of? Item
  assert_equal "Pencil", item.name
end

def test_it_instantiates_an_item_object_with_parameters_from_spec
    data = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    item = Item.new(data)
    assert item.instance_of? Item
  end

def test_item_class_has_access_to_item_info
  data = {
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => BigDecimal.new(10.99,4),
    :created_at  => Time.now,
    :updated_at  => Time.now,
  }
  item = Item.new(data)
  assert_equal "Pencil", item.name
  assert_equal "You can use it to write things", item.description
  # assert_in_delta BigDecimal.new(10.99,5), (500.0 / 10**6), item.unit_price
  # assert_equal Time.now, item.created_at
  # assert_equal Time.now, item.updated_at

end

end
