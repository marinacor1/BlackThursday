require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test

def test_it_instantiates_an_item_object
  item = Item.new
  assert item.instance_of? Item
end


end
