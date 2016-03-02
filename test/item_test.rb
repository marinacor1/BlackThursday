require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test

def test_it_instantiates_an_item_object
  item = Item.new({id: 521, name: "Fluffernutter", description: "It's a thing!", unit_price: 2000, merchant_id: 45, created_at: "01/01/01", updated_at: "08/08/08"})
  #
  # binding.pry
  assert item.instance_of? Item
  assert_equal "Fluffernutter", item.name
  # binding.pry
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
end
